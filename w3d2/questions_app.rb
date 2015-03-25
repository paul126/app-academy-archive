require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')

    self.results_as_hash = true
    self.type_translation = true
  end

end

class User

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
      SQL
    User.new(result[0])
  end

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ?
          AND
        users.lname = ?
      SQL
    User.new(result[0])
  end

  def authored_questions
    questions = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.user_id = ?
      SQL
    questions.map do |hash|
      Question.new(hash)
    end
  end

  def authored_replies

    Reply.new.find_by_user_id(@id)

  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma

    karma = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        COUNT(question_likes.user_id)/CAST(COUNT( DISTINCT questions.title) AS FLOAT) AS value
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?
      SQL
    karma[0]["value"]
  end

  def instance_hash
    inst_hash = {}
    inst_arr = a.instance_variables
    inst_arr.each_with_index do |key, i|
      inst_hash[key] = inst_arr[i].to_s[1..-1]
    end
    inst_hash
  end

  def save

    if !self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end

  end
end

class Question

  attr_accessor :id, :title, :body, :user_id

  def initialize(options = {})
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
      SQL
    Question.new(result[0])
  end

  def find_by_title(title)
    result = QuestionsDatabase.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.title = ?
      SQL
    Question.new(result[0])
  end

  def find_by_author(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.user_id = ?
    SQL
    questions.map do |question|
      Question.new(question)
    end

  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL
    User.new(author[0])
  end

  def replies

    Reply.new.find_by_question_id(@id)
    # replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
    # SELECT
    #   *
    # FROM
    #   replies
    # WHERE
    #   replies.question_id = ?
    # SQL
    # replies.map do |reply|
    #   Reply.new(reply)
    # end
  end

  def followers

    QuestionFollower.followers_for_question_id(@id)

  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def save

    if !self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id, id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end

  end

end

class QuestionFollower

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        question_followers.id = ?
      SQL
    QuestionFollower.new(result[0])
  end

  def self.followers_for_question_id(question_id)

    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)

    SELECT
      users.*
    FROM
      question_followers
    JOIN
      users ON question_followers.user_id = users.id
    WHERE
      question_followers.question_id = ?
    SQL

    followers.map do |follower|
      User.new(follower)
    end

  end

  def self.followed_questions_for_user_id(user_id)

    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)

    SELECT
      DISTINCT questions.*
    FROM
      questions
    JOIN
      question_followers ON question_followers.question_id = questions.id
    WHERE
      question_followers.user_id = ?
    SQL

    questions.map do |question|
      Question.new(question)
    end

  end

  def self.most_followed_questions(n)

    top_questions = QuestionsDatabase.instance.execute(<<-SQL, n)

    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_followers ON question_followers.question_id = questions.id
    GROUP BY
      questions.title
    ORDER BY
      COUNT(questions.user_id) DESC
    LIMIT
      ?
    SQL

    top_questions.map do |question|
      Question.new(question)
    end

  end

end

class Reply

  attr_accessor :id, :question_id, :parent_reply, :user_id, :body

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
    @parent_reply = options["parent_reply"]
    @body = options["body"]
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
      SQL
    Reply.new(result[0])
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.question_id = ?
    SQL
    replies.map do |reply|
      Reply.new(reply)
    end

  end

  def self.find_by_user_id(user_id)

    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.user_id = ?
      SQL
    replies.map do |hash|
      Reply.new(hash)
    end
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL
    User.new(author[0])
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = ?
    SQL
    Question.new(question[0])
  end

  def parent_reply
    parent = QuestionsDatabase.instance.execute(<<-SQL, @parent_reply)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.id = ?
    SQL
    Reply.new(parent[0])
  end

  def child_replies

    children = QuestionsDatabase.instance.execute(<<-SQL, @id)

    SELECT
      *
    FROM
      replies
    WHERE
      replies.parent_reply = ?
    SQL

    children.map do |child|
      Reply.new(child)
    end

  end

  def save

    if !self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_reply, user_id, body, id)
      UPDATE
        replies
      SET
      question_id = ?, parent_reply = ?, user_id = ?, body = ?
      WHERE
        id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_reply, user_id, body)
      INSERT INTO
        replies (question_id, parent_reply, user_id, body)
      VALUES
        (?, ?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end

  end

end

class QuestionLike

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?
      SQL
    QuestionLike.new(result[0])
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      question_likes ON (users.id = question_likes.user_id)
    WHERE
      question_likes.question_id = ?
    SQL

    likers.map { |user| User.new(user) }

  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(question_likes.user_id)
    FROM
      question_likes
    WHERE
      question_likes.question_id = ?
    SQL
    likes[0]["COUNT(question_likes.user_id)"]

  end

  def self.liked_questions_for_user_id(user_id)
    questions_liked = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id = questions.id
    WHERE
      question_likes.user_id = ?
    SQL

    questions_liked.map { |question| Question.new(question)}
  end

  def self.most_liked_questions(n)
    top_questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id = questions.id
    GROUP BY
      questions.title
    ORDER BY
      COUNT(question_likes.user_id) DESC
    LIMIT
      ?
    SQL
    top_questions.map { |ques| Question.new(ques) }
  end

end
