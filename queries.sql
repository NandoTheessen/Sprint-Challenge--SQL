--- 1. List all organization `name`s.
SELECT name FROM organization;

--- 2. List all channel `name`s.
SELECT name FROM channel;

-- 3. List all channels in a specific organization by organization `name`.
SELECT o.name, c.name FROM channel AS c, organization AS o
GROUP BY c.name;

-- 4. List all messages in a specific channel by channel `name` `#general` in
--    order of `post_time`, descending.
SELECT m.timestamp, m.body, c.name
FROM channel AS c, messages AS m
WHERE c.name == (SELECT id FROM channel WHERE name == '#general')
ORDER BY m.timestamp DESC;

-- 5. List all channels to which user `Alice` belongs.
SELECT channel.name, channel.id 
FROM channel 
INNER JOIN user_channel AS u_c ON channel.id == u_c.ch_id 
INNER JOIN user ON user.id == u_c.u_id 
WHERE user.name == "Alice";

--6. List all users that belong to channel `#general`.
SELECT user.name 
FROM user 
INNER JOIN user_channel AS u_c ON user.id == u_c.u_id 
INNER JOIN channel ON channel.id == u_c.ch_id 
WHERE channel.name == "#general";

--7. List all messages in all channels by user `Alice`.

SELECT body FROM messages 
INNER JOIN user ON message.u_id == user.id 
WHERE user.name == "Alice";

-- 8. List all messages in `#random` by user `Bob`.
SELECT body FROM messages 
INNER JOIN user ON messages.u_id == user.id 
INNER JOIN channel ON messages.ch_id = channel.id
WHERE user.name == "Bob" AND
channel.name == "#random";

-- 9. List the count of messages across all channels per user. (Hint:
--    `COUNT`, `GROUP BY`.)

SELECT user.name AS "User Name", count(u_id) AS "Message Count" FROM messages
INNER JOIN user ON messages.u_id == user.id
INNER JOIN channel WHERE messages.ch_id == channel.id
GROUP BY user.id;

-- 10. [Stretch!] List the count of messages per user per channel.
SELECT user.name AS "User Name", channel.name as "Channel", count(messages.id) AS "Message Count" 
FROM messages, user, channel
WHERE messages.u_id == user.id 
AND messages.ch_id == channel.id
GROUP BY messages.u_id;

-- 6. The Keyword you are looking for is CASCADE