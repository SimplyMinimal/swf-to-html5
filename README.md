# swf-to-html5
Automatically build a website that plays Adobe Flash SWF files using Ruffle


Rudimentary step-by-step until I make this pretty:

Step 1) Clone this repo:
`git clone https://github.com/SimplyMinimal/swf-to-html5`


Step 2) Clone ruffle repo (either get the latest or just use mine):

`git clone https://github.com/SimplyMinimal/ruffle`


Step 3) Drop SWF files in assets folder


Step 4) run `./generate_htmlfiles.sh` to build initial website. It will output an index.html file. Once generated, you're done! You're ready to upload all files to a web server. For a quick test run the [python simple server](https://docs.python.org/2/library/simplehttpserver.html) in the root directory.


Step 5) OPTIONAL: If you'd like to generate thumbnails of all your SWF files in batch then run the following:
`./build_thumbnails.sh && ./generate_htmlfiles.sh`
