---
layout: post
title: Easy Bash Function to Check a Cryptocurrency's Price
permalink: /crypto-price-bash-function
date: 2018/05/17
tags: bash, cryptocurrency
---

There are many many command-line applications out there for cryptocurrencies. Many crypto-related sites offer a good API with good documentation, so it's easy to develop CLI tools for crypto. I wanted something that simply fetched the price of an individual cryptocurrency via the command-line. I don't like having to visit a site like [Coin Market Cap](https://coinmarketcap.com) just to get a single numeric value that could easily be fetched and piped into terminal window.

I live in the terminal; almost to a fault. I can easily call up a Hotkey Window in iTerm 2 with a double-tap of the <kbd>⌘ command</kbd> key. A cryptocurrency ticker is easy to find with a simple GitHub search, but I find many of the CLI tools people develop to be far too bloated for this use case, and definitely shouldn't require that I wait for a slow Python interpreter just to fetch the price of Bitcoin.

So let's build our own tool with the shell's native language: bash. This function is extremely easy since we're simply making an API call, and then parsing the JSON response. The tools we'll use for this are `curl` and `jq`. `curl` will fetch the data and `jq` will parse the response for us. Easy.

## CoinCap.io

I'll use [CoinCap.io's](http://coincap.io) API for this for two reasons:

1. CoinCap structures the URLs for individual coin data pages with the ticker symbol as the suffix. In contrast, Coin Market Cap uses the full name of the cryptocurrency for their v1 API, and a proprietary "id" number for their updated v2 API. It's much simpler to build the request url for CoinCap.io, which allows this *simple* function to be as short as possible.
2. CoinCap updates their prices more regularly than Coin Market Cap (Coin Market Cap states they only update every 5 minutes).

The only caveat is CoinCap's API is really unreliable for listing a cryptocurrency's price in BTC. Many individual data sets only contain the price in USD, so we'll just live with that for the bash function.

## jq

[jq](https://stedolan.github.io/jq/) is a simple command-line JSON processor. You'll need to install this if you're on macOS (`brew install jq`). jq makes it really easy to parse JSON data from the `curl` request.

## The function

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
