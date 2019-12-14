# wordpress_setup
shell script to setup a wp site

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
 	vim passd.sh
```

Install all 

```
sudo ./sp-lamp.sh
```


 
