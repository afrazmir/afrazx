create database media_company1

use media_company1
go
CREATE TABLE userx (
    user_id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(50)
);
INSERT INTO users (user_id, username, email, password, role) VALUES
(1, 'admin_user', 'admin@example.com', 'adminpass', 'admin'),
(2, 'editor_user', 'editor@example.com', 'editorpass', 'editor'),
(3, 'writer_user', 'writer@example.com', 'writerpass', 'writer'),
(4, 'viewer_user', 'viewer@example.com', 'viewerpass', 'viewer'),
(5, 'guest_user', 'guest@example.com', 'guestpass', 'guest');

CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    author_id INT,
    publish_date DATE,
    FOREIGN KEY (author_id) REFERENCES users(user_id)
);

INSERT INTO articles (article_id, title, content, author_id, publish_date) VALUES
(1, 'Breaking News', 'This is a breaking news article.', 3, '2024-01-20'),
(2, 'Tech Trends', 'Exploring the latest technology trends.', 2, '2024-01-19'),
(3, 'Entertainment Buzz', 'Highlights from the world of entertainment.', 4, '2024-01-18'),
(4, 'Health and Wellness', 'Tips for a healthy lifestyle.', 3, '2024-01-17'),
(5, 'Travel Adventures', 'Discover amazing travel destinations.', 2, '2024-01-16');
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);
INSERT INTO categories (category_id, category_name) VALUES
(1, 'News'),
(2, 'Technology'),
(3, 'Entertainment'),
(4, 'Health'),
(5, 'Travel');

CREATE TABLE article_category (
    article_id INT,
    category_id INT,
    PRIMARY KEY (article_id, category_id),
    FOREIGN KEY (article_id) REFERENCES articles(article_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
INSERT INTO article_category (article_id, category_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    article_id INT,
    user_id INT,
    comment_text TEXT,
    comment_date TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(article_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);




INSERT INTO comments (comment_id, article_id, user_id, comment_text, comment_date) VALUES
(101, 1, 4, 'Great coverage!', DEFAULT),
(102, 2, 5, 'Interesting read!', DEFAULT),
(103, 3, 2, 'I love this show!', DEFAULT),
(104, 4, 1, 'Thanks for the tips.', DEFAULT),
(105, 5, 3, 'Dream destinations indeed!', DEFAULT);

SELECT * FROM users;
SELECT * FROM articles;
SELECT * FROM categories;
SELECT * FROM article_category;
SELECT * FROM comments;

SELECT articles.title, users.username AS author, categories.category_name
FROM articles
INNER JOIN users ON articles.author_id = users.user_id
INNER JOIN article_category ON articles.article_id = article_category.article_id
INNER JOIN categories ON article_category.category_id = categories.category_id;

UPDATE users
SET role = 'editor'


SELECT articles.title, users.username AS author
FROM articles
INNER JOIN users ON articles.author_id = users.user_id
WHERE users.role = 'editor';

SELECT username
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM comments
    WHERE article_id = 1
);
CREATE INDEX idx_user_id ON users(user_id);

CREATE VIEW vw AS
SELECT title
FROM articles;