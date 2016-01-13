from subprocess import call
import sys

# call(["sudo yum -y install libxml2-devel libxslt-devel"], stdout = sys.stdout, shell=True)
# call(["sudo yum -y install gcc"], stdout = sys.stdout, shell=True)
# call(["sudo yum -y install git"], stdout = sys.stdout, shell=True)
# call(["sudo pip install requests"], stdout = sys.stdout, shell=True)
# call(["sudo pip install lxml"], stdout = sys.stdout, shell=True)
call(["git", "pull"], stdout = sys.stdout)
call(["rm data/*.xml"], shell=True)
call(["rm jekyll/notifications/*.md"], stdout = sys.stdout, shell=True)
import scraper.eConsult2Github
call(["git", "add", "data/*.xml"])
call(["git", "add", "jekyll/notifications/*.md"])
call(["git", "commit", "-a", "-m" "'Automatic refresh'"], stdout = sys.stdout)
call(["git", "push", "origin", "master"], stdout = sys.stdout)
call(["git", "subtree", "push", "--prefix", "jekyll", "origin", "gh-pages"], stdout = sys.stdout)
