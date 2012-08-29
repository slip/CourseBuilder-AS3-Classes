import unittest
from CourseUpdater import CourseUpdater


class CourseUpdaterTest(unittest.TestCase):

    def setUp(self):
        self.courseUpdater = CourseUpdater('/Users/slip/Desktop/IT1001/')

    def tearDown(self):
        self.courseUpdater = None

    def test_get_course_title(self):
        self.assertEqual("AcutesMobile", self.courseUpdater.course_title)

    def test_get_course_directory(self):
        self.assertEqual('/Users/slip/Desktop/IT1001/', self.courseUpdater.course_directory)

    def test_add_new_files(self):
        self.courseUpdater.add_new_files()

if __name__ == '__main__':
    unittest.main()
