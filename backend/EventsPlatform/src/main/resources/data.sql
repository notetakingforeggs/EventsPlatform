-- Insert sample users
INSERT INTO app_user (firebase_uid, google_uid, name, email, refresh_token, is_staff)
VALUES
('firebaseUid_1', 'googleUid_1', 'Alice Johnson', 'alice@example.com', 'refresh_token_1', true),
('firebaseUid_2', 'googleUid_2', 'Bob Smith', 'bob@example.com', 'refresh_token_2', false),
('firebaseUid_3', 'googleUid_3', 'Charlie Brown', 'charlie@example.com', 'refresh_token_3', false),
('firebaseUid_4', 'googleUid_4', 'Daisy Williams', 'daisy@example.com', 'refresh_token_4', false),
('firebaseUid_5', 'googleUid_5', 'Ethan White', 'ethan@example.com', 'refresh_token_5', true);

-- Insert sample events
INSERT INTO app_event (event_name,event_description, start_date, end_date)
VALUES
('Trampoline Conference', 'Conference to talk about trampoining all day long', 1738598400, 1738602000),
('Handstand CLass', 'My first handstand class', 1738684800, 1738688400),
('Aerial Silks Workshop', 'Learn the fundamentals of aerial silks and basic climbs', 1738752000, 1738755600),
('Juggling Masterclass', 'Improve your juggling skills with balls, clubs, and rings', 1738838400, 1738842000),
('Tightrope Walking Basics', 'An introduction to balance and technique on the tightrope', 1738924800, 1738928400),
('Acrobatics Fundamentals', 'Learn tumbling, partner balancing, and flexibility drills', 1739011200, 1739014800),
('Fire Spinning Safety & Tricks', 'Master the basics of poi and staff spinning safely', 1739097600, 1739101200);

-- Insert attendees (linking users to events)
INSERT INTO attendee (user_id, event_id, confirmed)
VALUES
(1, 1, true),
(2, 1, false),
(3, 2, true),
(4, 3, false),
(5, 3, true),
(1, 4, true),
(2, 4, false),
(3, 5, true),
(4, 6, true),
(5, 7, false);
