from subprocess import call
import sys

def lambda_handler(event, context):
    call(["pip", "install", "requests"])
    call(["pip", "install", "lxml"])
    call(["git", "pull"], stdout = sys.stdout)
    call(["rm data/*.xml"], shell=True)
    call(["rm jekyll/notifications/*.md"], shell=True)
    import scraper.eConsult2Github
    call(["git", "commit", "-a", "-m" "'Automatic refresh'"])
    call(["git", "push", "origin", "master"])
    call(["git", "subtree", "push", "--prefix", "jekyll", "origin", "gh-pages"])
    return 0
    
if __name__ == "__main__":
    lambda_handler(None, None)