# PF-Chain
PF-Chain was developed as a command line interface tool for Bash. The only dependencies are python 3 and wget
 
First check what version of python you currently have with  
`python --version`  
If you do not have python 3 installed run the following commands  
`sudo apt update`  
`sudo apt install python3`  
You should now be able to run PF-Chain with
`./pitch.sh 'Artist Name'

Note that this project is still in development and many important features are not yet implemented.
When searching for an artist make sure to you use quotes so that the program may use the entire name as a single string
Also avoid using special characters as they may result in errors. Check out the bugs page to find out more.
PF-Chain works by modifying the argument of PF-Chain and using wget to download the pitchfork page for that string
