from subprocess import call
import sys

def lambda_handler(event, context):
    call(["sudo yum -y install gcc"], stdout = sys.stdout, shell=True)
    call(["sudo yum -y install git"], stdout = sys.stdout, shell=True)
    call(["pip", "install", "requests"], stdout = sys.stdout)
    call(["pip", "install", "lxml"], stdout = sys.stdout)
    call(["git", "pull"], stdout = sys.stdout)
    call(["rm data/*.xml"], shell=True)
    call(["rm jekyll/notifications/*.md"], stdout = sys.stdout, shell=True)
    import scraper.eConsult2Github
    call(["git", "commit", "-a", "-m" "'Automatic refresh'"], stdout = sys.stdout)
    call(["git", "push", "origin", "master"], stdout = sys.stdout)
    call(["git", "subtree", "push", "--prefix", "jekyll", "origin", "gh-pages"], stdout = sys.stdout)
    return 0
    
if __name__ == "__main__":
    lambda_handler(None, None)