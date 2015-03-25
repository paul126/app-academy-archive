Create TABLE users(
id INTEGER PRIMARY KEY,
fname VARCHAR(255) NOT NULL,
lname VARCHAR(255) NOT NULL
);

Create TABLE questions(
id INTEGER PRIMARY KEY,
title VARCHAR(255) NOT NULL,
body VARCHAR(255) NOT NULL,
user_id INTEGER NOT NULL
);

Create TABLE question_followers(
id INTEGER PRIMARY KEY,
user_id INTEGER NOT NULL,
question_id INTEGER NOT NULL
);

Create TABLE replies(
id INTEGER PRIMARY KEY,
question_id INTEGER NOT NULL,
user_id INTEGER NOT NULL,
parent_reply INTEGER,
body VARCHAR(255)
);

Create TABLE question_likes(
id INTEGER PRIMARY KEY,
user_id INTEGER NOT NULL,
question_id INTEGER NOT NULL
);

-------------------------------------

INSERT INTO
  users (fname, lname)
VALUES
  ('Vincent', 'Carbonaro'), -- 1
  ('Paul', 'Banel'); -- 2

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('question1', '1?', 1),
  ('question2', '2?', 2),
  ('question3', '3?', 2),
  ('question4', '4?', 1),
  ('question5', '5?', 2),
  ('question6', '6?', 1);

INSERT INTO
  question_followers(user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (1, 2),
  (2, 3),
  (1, 4),
  (1, 5),
  (2, 5);

INSERT INTO
  replies(question_id, user_id, parent_reply, body)
VALUES
  (1, 2, NULL, 'Question1 Reply'),
  (1, 2, 1, 'Question1 Reply Reply'),
  (3, 1, NULL, 'Question3 Reply'),
  (5, 1, NULL, 'Question5 Reply'),
  (5, 2, 4, 'Question5 Reply Reply');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (1, 2),
  (2, 2),
  (2, 4),
  (1, 6),
  (2, 6);
