-- Insert sample users
INSERT INTO app_user (firebase_uid, google_uid, name, email, refresh_token, is_staff)
VALUES
('firebaseUid_1', 'googleUid_1', 'Alice Johnson', 'alice@example.com', 'refresh_token_1', true),
('firebaseUid_2', 'googleUid_2', 'Bob Smith', 'bob@example.com', 'refresh_token_2', false),
('firebaseUid_3', 'googleUid_3', 'Charlie Brown', 'charlie@example.com', 'refresh_token_3', false);

-- Insert sample events
INSERT INTO app_event (event_name,event_details, start_date, end_date)
VALUES
('Trampoline Conference', 'Conference to talk about trampoining all day long', 1738598400, 1738602000),
('Handstand CLass', 'My first handstand class', 1738684800, 1738688400);

-- Insert attendees (linking users to events)
INSERT INTO attendee (user_id, event_id, confirmed)
VALUES
(1, 1, true),
(2, 1, false),
(3, 2, true);
