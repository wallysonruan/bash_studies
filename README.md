# Bash Studies

In my last project I had to use Ubuntu:20.04, and I needed to use Bash for a couple tasks. That showed me how important it's to really understand and know Bash, So I created this repository to store all Bash scripts I'll write during my studies.

P.S.: I strongly advise the use of alias. I use the code below to get the most of the scripts.

'''
alias remove-i="bash <path>/<to>/remove_all_containers_images.sh"
alias remove-c="bash <path>/<to>/remove_all_containers.sh"
'''

## Scripts

### 1. File Comparator
I found this [10 Bash Script Code Challenges for Beginners](https://codecademy.com/resources/blog/bash-script-code-challenges-for-beginners/) list of challenges, and I liked the first one. While I was writing it, I noticed I could do something more exciting, such as a file comparator similar to the one GitHub has.

#### Usage

Execute the command below, it will output the updated file highlighting the changes.

'''
bash compare_files.sh <original file path> <updated file path>
'''

#### How does it works?
- Check if both are valid file paths, if not, abort the operation.
- Load both file contents as lines.
- Check what is the highest amount of lines.
- Go over the updated file, and compare each of its lines to their correspondent one in the original file - using their index.
- Prints an "diff header" before the new line if its not the first line, or if the previous line is not a diff one too. 

### 2. remove-c / remove-i
#### Usage

Go to the scripts path and execute the command below, it will output the deleted containers id.

'''
bash <script-name>
'''

#### How does it works?
- Uses docker cli commands to get the list of the current containers or images
- Loops over the list forcing the removal/deletion of each.
