---
layout: post
title: Easy Bash Function to Check a Cryptocurrency's Price
permalink: /crypto-price-bash-function
date: 2018/05/17
tags: bash, cryptocurrency
---



```
function coin () {
	url=$(curl -s http://coincap.io/page/${1^^})
	name=$(echo $url | jq -cr '.display_name')
	price=$(echo $url | printf "%.2f\n" $(jq '.price_usd'))
	echo $name" (${1^^}) \$"$price
}
```

### Example Usage

```bash
coin btc
Bitcoin (BTC) $8088.48
```


## How it Works

```
url=$(curl -s http://coincap.io/page/${1^^})
```
Defines the `curl` request to append the argument to the base URL while converting the string to uppercase. The `-s` flag silences the typical output of a `curl` command. `${1^^}` is our command-line argument converted to uppercase.

```
name=$(echo $url | jq -cr '.display_name')
```
When we echo the `$name` variable, it will parse the full name of the cryptocurrency from the CoinCap data. The `-cr` flag simply prevents jq from putting the string in quotation marks.

```
price=$(echo $url | printf "%.2f\n" $(jq '.price_usd'))
```
This is similar to the name request, however, this nests the `jq` command inside a `printf` function. This truncates the price to two decimal places.

```
echo $name" (${1^^}) \$"$price
```
This is what actually gets printed to the terminal. We call the `$name` and `$price` variables while repeating the `${1^^}` we used to build the URL to display all our necessary info, and nothing more. We also throw a dollar sign in front of the USD price for nicer formatting.
