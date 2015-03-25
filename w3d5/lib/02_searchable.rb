require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    col_names = params.keys.map { |key| key.to_s }
    col_names_string = col_names.join(' = ? AND ') + ' = ?'
    search_terms = params.values.map { |key| key.to_s }
    results = DBConnection.execute(<<-SQL, *search_terms)
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      #{col_names_string}
    SQL


    results_arr = []
    results.each_with_index do |obj|
      obj2 = {}
      obj.each do |key, val|
        obj2[key.to_sym] = val
      end
      results_arr << self.new(obj2)
    end
    results_arr

  end

end

class SQLObject
  extend Searchable
end
