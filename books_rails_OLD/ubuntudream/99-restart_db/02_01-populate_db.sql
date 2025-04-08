INSERT INTO users (id, username, email, encrypted_password, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$12$x/A/gioZz2yLD6QHAZwE0.VPp0ZjILzbExYCTlU8.YYvd9Km5nEYO', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (2, 'Bob', 'bob@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (3, 'Carl', 'carl@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (4, 'David', 'david@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (5, 'Elvis', 'elvis@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO users (id, username, email, created_at, updated_at) VALUES (6, 'Fla', 'fla@test.abc', '2022-10-08 23:30:28.257872', '2022-10-08 23:30:28.257872');
INSERT INTO lessons (id, description, description_rtf, duration, name, picture_author_name, picture_museum_name, created_at, updated_at) VALUES (1, 'Ann', 'ann@test.abc', '$2a$EYO', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
INSERT INTO mobility_string_translations (id, locale, key, value, translatable_type, translatable_id, created_at, updated_at) 
VALUES 
  (1, 'en', 'name', 'View of mount Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872'),
  (2, 'it', 'name', 'Veduta del monte Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
  (3, 'pt', 'name', 'Vista do monte Vernon', 'Lesson', 1, '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
INSERT INTO steps (id, question, answer, lesson_id, youtube_video_id, created_at, updated_at) 
VALUES 
  (1, 'Quante persone ci sono?', 'Ci sono sei persone.', 1, 'bJJpGBBlsy4', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872'),
  (2, 'Che colore è il cane?', 'Nero.', 1, 'eg_6CxTEiL8', '2023-01-01 23:30:30.257872', '2023-01-01 23:30:30.257872');
