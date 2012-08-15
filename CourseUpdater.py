from os import listdir


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

files_to_keep = ["course.xml", "test.xml", "coursefiles"]
cu = CourseUpdater("/Users/slip/Desktop/GAMETEST")

for keeper in files_to_keep:
    print "removing %s from %s" % (keeper, cu.course_files)
    cu.course_files.remove(keeper)

