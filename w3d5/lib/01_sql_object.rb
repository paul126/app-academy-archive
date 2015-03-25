require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    col_names = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    col_syms = []
    col_names[0].each do |column|
       col_syms << column.to_sym
    end
    col_syms

  end

  def self.finalize!

    columns.each do |col|
      define_method("#{col.to_s}") { attributes[col] }
    end

    columns.each do |col|
      define_method("#{col.to_s}=") { |val| attributes[col] =  val }
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = "#{self}".tableize if @table_name.nil?
    @table_name
  end

  def self.all
    all_entries = DBConnection.execute(<<-SQL)
    SELECT
      #{table_name}.*
    FROM
      #{table_name}
    SQL

    objs_arr = []
    all_entries.each_with_index do |obj|
      obj2 = {}
      obj.each do |key, val|
        obj2[key.to_sym] = val
      end
      objs_arr << self.new(obj2)
    end
    objs_arr
  end

  def self.parse_all(results)
    obj_arr = []

    results.each do |obj|
      obj_arr << self.new(obj)
    end

    obj_arr
  end

  def self.find(id)
    find_id = DBConnection.execute(<<-SQL)
    SELECT
      #{table_name}.*
    FROM
      #{table_name}
    WHERE
      id = #{id}
    SQL
    return nil if find_id.empty?

    find_id2 = {}
    find_id[0].each do |key, val|
      find_id2[key.to_sym] = val
    end
    self.new(find_id2)
  end

  def initialize(params = {})

    params.each do |key, value|

      raise "unknown attribute '#{key.to_s}'" unless self.class.columns.include?(key) || key.to_s == 'id'
      attributes[key.to_sym] = value
    end

  end

  def attributes
    @attributes = {} if @attributes.nil?
    @attributes
  end

  def attribute_values
    attr_array = []
    attributes.each_value do |val|
      attr_array << val
    end
    p attributes
    p attr_array
    attr_array
  end

  def insert
    col_names = self.class.columns
    col_names.shift
    col_string = col_names.join(', ')
    num_qs = col_names.count
    question_marks = (['?'] * num_qs).join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_string})
    VALUES
      (#{question_marks})
    SQL

    attributes[:id] = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.join(' = ?, ') + ' = ?'
    id = attributes[:id]
    DBConnection.execute(<<-SQL, *attribute_values, id)
    UPDATE
      #{self.class.table_name}
    SET
      #{col_names}
    WHERE
      id = ?
    SQL

  end

  def save
    if self.id.nil?
      insert
    else
      update
    end
  end
end
