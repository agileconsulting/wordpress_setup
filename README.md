# wordpress_setup
shell script to setup a wp site. You must start with an ubuntu installation and install all sofware required (Apache mysql ecc). After that you can create n site in your vps node and manage from command line with wp client. This way you can create wordpress site more quickly. 
First create an administrator user  with this command
```
adduser admin
```

and then 

```
usermod -aG sudo admin
```
After that logout from root username and log with admin

Start by updating the package index:

```
sudo apt update
```

Install git

```
sudo apt-get -y install git
```

Clone
```
git clone https://github.com/agileconsulting/wordpress_setup/
```

Goto to dir

```
cd wordpress_setup/
```


Make shell executable 	
```
chmod +x sp-lamp.sh
``` 

Edit password and configuration file
 ```
vi passwd.sh
```
Install lamp 

```
sudo ./sp-lamp.sh
```


Make shell executable 	
```
chmod +x wp-go.sh
```

Install all 

```
sudo ./wp-go.sh
```


 
