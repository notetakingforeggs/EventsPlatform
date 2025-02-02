-- Insert sample users
INSERT INTO app_user (firebase_uid, google_uid, name, email, refresh_token, is_staff)
VALUES
('firebaseUid_1', 'googleUid_1', 'Alice Johnson', 'alice@example.com', 'refresh_token_1', true),
('firebaseUid_2', 'googleUid_2', 'Bob Smith', 'bob@example.com', 'refresh_token_2', false),
('firebaseUid_3', 'googleUid_3', 'Charlie Brown', 'charlie@example.com', 'refresh_token_3', false);

-- Insert sample events
INSERT INTO app_event (event_name, start_date, end_date)
VALUES
('Trampoline Conference', 'Conference to talk about trampoining all day long', '2025-05-01T10:00:00Z', '2025-05-01T18:00:00Z'),
('Handstand CLass', 'My first handstand class', '2025-06-15T18:00:00Z', '2025-06-15T22:00:00Z');

-- Insert attendees (linking users to events)
INSERT INTO attendee (user_id, event_id, confirmed)
VALUES
(1, 1, true),
(2, 1, false),
(3, 2, true);
