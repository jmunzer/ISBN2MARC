This tool is for the bulk retrieval of .marc (marc21) files from CAPITA Soprano via the API tools.

# Input
Place a .csv file of line-seperated ISBNs in the working folder. (be aware - all .csv files in folder will be processed, so remember to clean up after yourself!)

# Process
Update $isbnbase variable to point at your institution-specific API endpoint
Run marc_retrieve.cmd
Input your Soprano operator ID and PW to authenticate against the API
a marc file will be created with an 'e-' suffix for each ISBN record match found
Use MarcJoin to merge individual files into a single file to work from
