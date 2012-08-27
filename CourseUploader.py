import ftplib
import os


class CourseUploader(object):
    """CourseUploader will upload the course to staging"""
    staging = ftplib.FTP("www.theserver.com")

    def __init__(self, course):
        super(CourseUploader, self).__init__()
        self.course = course

    def course_title(self):
        pass

    def connect_to_staging(self):
        filenames = []
        self.staging.login("user", "pass")
        self.staging.retrlines('NLST', filenames.append)
        print filenames

    def download_files(self, filenames):
        for filename in filenames:
            local_filename = os.path.join('Users/slip/Desktop/', filename)
            file = open(local_filename, 'wb')
            self.staging.retrbinary('RETR ' + filename, file.write)


def main():
    cu = CourseUploader("testing")
    cu.connect_to_staging()

main()
