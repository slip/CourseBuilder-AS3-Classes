from os import listdir
from subprocess import call
from xml.dom.minidom import parseString


class CourseUpdater(object):
    """CourseUpdater will remove old lmsfiles and replace them with new ones"""
    files_to_keep = ["course.xml", "test.xml", "coursefiles"]
    course_directory = ""
    course_files = []
    course_title = ""

    def __init__(self, course_directory):
        "initialize a new CourseUpdater instance"
        self.course_directory = course_directory
        self.course_files = listdir(self.course_directory)

    def getCourseTitle(self):
        "traverse imsmanifest.xml and extract the course title"
        manifestLocation = "%s/imsmanifest.xml" % self.course_directory
        manifestFile = open(manifestLocation, 'r')
        manifestData = manifestFile.read()
        manifestFile.close()
        manifestDom = parseString(manifestData)
        self.course_title = manifestDom.getElementsByTagName('title')[0].firstChild.data
        print self.course_title
        return self.course_title

    def removeOldFiles(self):
        "deletes legacy lms files to be replaced"
        for keeper in self.files_to_keep:
            print "removing %s from %s" % (keeper, self.course_files)
            self.course_files.remove(keeper)

    def addNewFiles(self):
        "replaces deleted files with new working files"

cu = CourseUpdater("/Users/slip/Desktop/GAMETEST")
print "course_directory: %s \ncourse_title = %s" % (cu.course_directory, cu.getCourseTitle())
call("imagesnap")
# print cu.course_directory
# print "here are all of the files in the directory:"
# print cu.course_files
# print "removing files_to_keep"
# cu.removeOldFiles()
# print "here are all of the remaining files"
# for remainingFile in cu.course_files:
#     print remainingFile
