from os import listdir
from fnmatch import fnmatch


class CourseUpdater(object):
    """CourseUpdater will remove old lmsfiles and replace them with new ones"""

    def __init__(self, course_directory):
        "initialize a new CourseUpdater instance"
        self.course_directory = course_directory
        self.course_files = listdir(self.course_directory)

    def removeOldFiles(self):
        pass

    def addNewFiles(self):
        pass

cu = CourseUpdater("/Users/slip/Desktop/TST1001_NEW")
print len(cu.course_files)
for course_file in cu.course_files:
    if fnmatch(course_file, '*.xsd'):
        print course_file
