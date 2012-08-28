#!/usr/bin/python

import sys
import os
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
        self.course_files = os.listdir(self.course_directory)

    def get_course_title(self):
        "traverse imsmanifest.xml and extract the course title"
        manifestLocation = os.path.join(self.course_directory, "imsmanifest.xml")
        manifestFile = open(manifestLocation, 'r')
        manifestData = manifestFile.read()
        manifestFile.close()
        manifestDom = parseString(manifestData)
        self.course_title = manifestDom.getElementsByTagName('title')[0].firstChild.data

    def remove_old_files(self):
        "deletes legacy lms files to be replaced"
        for keeper in self.files_to_keep:
            self.course_files.remove(keeper)
        for file in self.course_files:
            file = os.path.join(self.course_directory, file)
            if os.path.exists(file):
                print "deleting %s" % os.path.basename(file)
                os.remove(file)

    def add_new_files(self):
        "replaces deleted files with new working files"


def main():
    cu = CourseUpdater(sys.argv[1])
    cu.remove_old_files()

if __name__ == '__main__':
    main()
