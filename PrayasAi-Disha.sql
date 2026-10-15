Create database prayasai_disha;
USE prayasai_disha;

CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL UNIQUE,
    branch_code VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    branch_id INT NOT NULL,
    cgpa DECIMAL(3,2) NOT NULL,
    interests TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_students_branch
ON students(branch_id);

CREATE INDEX idx_students_cgpa
ON students(cgpa);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_skills_category
ON skills(category);

CREATE TABLE student_skills (
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level VARCHAR(20) NOT NULL DEFAULT 'Intermediate',

    PRIMARY KEY (student_id, skill_id),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (skill_id)
        REFERENCES skills(skill_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE INDEX idx_student_skills_skill
ON student_skills(skill_id);

CREATE TABLE internships (
    internship_id INT AUTO_INCREMENT PRIMARY KEY,
    company VARCHAR(150) NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    location VARCHAR(100),
    min_cgpa DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    duration_months TINYINT UNSIGNED,
    stipend INT UNSIGNED,
    positions_available SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    application_deadline DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE INDEX idx_internships_location
ON internships(location);

CREATE INDEX idx_internships_mincgpa
ON internships(min_cgpa);

CREATE INDEX idx_internships_company
ON internships(company);

CREATE INDEX idx_internships_deadline
ON internships(application_deadline);

CREATE TABLE internship_skills (
    internship_id INT NOT NULL,
    skill_id INT NOT NULL,
    is_mandatory BOOLEAN NOT NULL DEFAULT TRUE,

    PRIMARY KEY (internship_id, skill_id),

    FOREIGN KEY (internship_id)
        REFERENCES internships(internship_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (skill_id)
        REFERENCES skills(skill_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE INDEX idx_internship_skills_skill
ON internship_skills(skill_id);

CREATE TABLE internship_eligible_branches (
    internship_id INT NOT NULL,
    branch_id INT NOT NULL,

    PRIMARY KEY (internship_id, branch_id),

    FOREIGN KEY (internship_id)
        REFERENCES internships(internship_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE INDEX idx_eligible_branches_branch
ON internship_eligible_branches(branch_id);

ALTER TABLE students
ADD COLUMN password_hash VARCHAR(255) NOT NULL AFTER email,
ADD COLUMN mobile_number VARCHAR(15) AFTER password_hash,
ADD COLUMN college VARCHAR(200) AFTER mobile_number,
ADD COLUMN degree VARCHAR(100) AFTER college,
ADD COLUMN graduation_year YEAR AFTER degree,
ADD COLUMN preferred_job_field VARCHAR(100) AFTER interests;
select*from students;

SELECT * FROM students;
SELECT * FROM skills;
INSERT INTO branches (branch_name, branch_code) VALUES
('Computer Science and Engineering', 'CSE'),
('Information Technology', 'IT'),
('Computer Science', 'CS'),
('Artificial Intelligence and Machine Learning', 'AIML'),
('Artificial Intelligence and Data Science', 'AIDS'),
('Electronics and Communication Engineering', 'ECE'),
('Electrical Engineering', 'EE'),
('Mechanical Engineering', 'ME'),
('Civil Engineering', 'CE');

INSERT INTO skills (skill_name, category) VALUES
('C', 'Programming'),
('C++', 'Programming'),
('Java', 'Programming'),
('Python', 'Programming'),
('JavaScript', 'Programming'),
('SQL', 'Database'),
('HTML', 'Web Development'),
('CSS', 'Web Development'),
('React', 'Web Development'),
('Node.js', 'Web Development'),
('Flask', 'Web Development'),
('FastAPI', 'Web Development'),
('Git', 'Tools'),
('Data Analysis', 'Data Science'),
('Machine Learning', 'AI/ML'),
('Deep Learning', 'AI/ML'),
('Cloud', 'Cloud Computing'),
('UI/UX', 'Design'),
('MongoDB', 'Database'),
('Power BI', 'Data Analytics');

ALTER TABLE students
MODIFY COLUMN cgpa DECIMAL(4,2) NOT NULL;

ALTER TABLE students
ADD COLUMN preferred_location VARCHAR(100) AFTER preferred_job_field;

ALTER TABLE students
ADD COLUMN preferred_work_mode VARCHAR(20) AFTER preferred_location;

ALTER TABLE internships
ADD COLUMN work_mode VARCHAR(20);

SELECT
    s.student_id,
    s.name,
    s.email,
    s.mobile_number,
    s.college,
    s.degree,
    b.branch_name,
    s.cgpa,
    s.graduation_year,
    s.interests,
    s.preferred_job_field,
    s.preferred_location,
    s.preferred_work_mode,
    GROUP_CONCAT(sk.skill_name ORDER BY sk.skill_name SEPARATOR ', ') AS skills
FROM students s
JOIN branches b
    ON s.branch_id = b.branch_id
LEFT JOIN student_skills ss
    ON s.student_id = ss.student_id
LEFT JOIN skills sk
    ON ss.skill_id = sk.skill_id
WHERE s.email = 'e2e.test@prayasai.com'
GROUP BY
    s.student_id,
    s.name,
    s.email,
    s.mobile_number,
    s.college,
    s.degree,
    b.branch_name,
    s.cgpa,
    s.graduation_year,
    s.interests,
    s.preferred_job_field,
    s.preferred_location,
    s.preferred_work_mode;
    
SELECT
    (SELECT COUNT(*) FROM branches) AS branches,
    (SELECT COUNT(*) FROM skills) AS skills,
    (SELECT COUNT(*) FROM students) AS students,
    (SELECT COUNT(*) FROM student_skills) AS student_skills,
    (SELECT COUNT(*) FROM internships) AS internships,
    (SELECT COUNT(*) FROM internship_skills) AS internship_skills,
    (SELECT COUNT(*) FROM internship_eligible_branches) AS internship_eligible_branches;
    USE prayasai_disha;
select*from students;

USE prayasai_disha;

DESCRIBE branches;
DESCRIBE skills;
DESCRIBE internships;
DESCRIBE internship_skills;
DESCRIBE internship_eligible_branches;
SELECT * FROM branches;

SELECT COUNT(*) AS internship_count FROM internships;
SELECT COUNT(*) AS skill_count FROM skills;
SELECT COUNT(*) AS internship_skill_count FROM internship_skills;
SELECT COUNT(*) AS eligible_branch_count FROM internship_eligible_branches;

SELECT * FROM skills;
DESCRIBE skills;
DESCRIBE internships;
DESCRIBE internship_skills;
DESCRIBE internship_eligible_branches;

USE prayasai_disha;

INSERT INTO skills (skill_name, category) VALUES
    ('.NET', NULL),
    ('ARM Microcontroller', NULL),
    ('AWS CloudFormation', NULL),
    ('Adobe Creative Suite', NULL),
    ('Adobe Photoshop', NULL),
    ('Algorithms', NULL),
    ('Analytical Thinking', NULL),
    ('Android', NULL),
    ('Artificial Intelligence', NULL),
    ('Automation', NULL),
    ('Branding', NULL),
    ('Business Development', NULL),
    ('C#', NULL),
    ('C#.NET', NULL),
    ('CI/CD', NULL),
    ('Canva', NULL),
    ('Claude', NULL),
    ('Cloud Firestore', NULL),
    ('Color Correction', NULL),
    ('Community Management', NULL),
    ('Computer Networking', NULL),
    ('Computer Networks', NULL),
    ('Content Management', NULL),
    ('Creative Writing', NULL),
    ('Dart', NULL),
    ('Data Interpretation', NULL),
    ('Data Structures', NULL),
    ('Digital Marketing', NULL),
    ('Django', NULL),
    ('Docker', NULL),
    ('Effective Communication', NULL),
    ('Email Marketing', NULL),
    ('English Proficiency (Spoken)', NULL),
    ('Express.js', NULL),
    ('Firebase', NULL),
    ('Flutter', NULL),
    ('Generative AI Tools', NULL),
    ('Google AdWords', NULL),
    ('Google Analytics', NULL),
    ('Google Keyword Planner', NULL),
    ('Google Search Console', NULL),
    ('Image Editing', NULL),
    ('Influencer Marketing', NULL),
    ('Instagram Marketing', NULL),
    ('Internet of Things (IoT)', NULL),
    ('Kubernetes', NULL),
    ('Lead Generation', NULL),
    ('LinkedIn Marketing', NULL),
    ('Linux', NULL),
    ('Logical Reasoning', NULL),
    ('MS-Excel', NULL),
    ('MS-Office', NULL),
    ('MS-PowerPoint', NULL),
    ('Market Analysis', NULL),
    ('Market Research', NULL),
    ('Marketing', NULL),
    ('Marketing Campaigns', NULL),
    ('Marketing Strategies', NULL),
    ('MySQL', NULL),
    ('Object Oriented Programming (OOP)', NULL),
    ('PHP', NULL),
    ('Performance Marketing', NULL),
    ('Problem Solving', NULL),
    ('REST API', NULL),
    ('Research and Analytics', NULL),
    ('Search Engine Marketing (SEM)', NULL),
    ('Search Engine Optimization (SEO)', NULL),
    ('Social Media Marketing', NULL),
    ('Software Testing', NULL),
    ('Technical Writing', NULL),
    ('Time Management', NULL),
    ('iOS', NULL)
ON DUPLICATE KEY UPDATE skill_name = VALUES(skill_name);

SELECT COUNT(*) AS total_skills FROM skills;

SELECT skill_id, skill_name, category
FROM skills
ORDER BY skill_id;

select*from students;

SELECT student_id, name, email
FROM students
WHERE email = 'kartikeyaverma01@gmail.com';

ALTER TABLE internships
ADD COLUMN source_url TEXT NULL;

SELECT internship_id, company, title, location, work_mode
FROM internships
LIMIT 5;

SELECT skill_id, skill_name
FROM skills
ORDER BY skill_name;

SELECT COUNT(*) FROM internships;

SELECT COUNT(*) FROM internship_skills;
SELECT COUNT(*) FROM internship_eligible_branches;

DESCRIBE internship_skills;
DESCRIBE internship_eligible_branches;
ALTER TABLE internships
MODIFY COLUMN location TEXT NULL;

SHOW INDEX FROM internships;
ALTER TABLE internships
DROP INDEX idx_internships_location;

ALTER TABLE internships
MODIFY COLUMN location TEXT NULL;

SELECT COUNT(*) AS internship_count
FROM internships;

select*from students;
select*from student_skills;
select * from skills;
select * from internship_skills;
select * from internships;
