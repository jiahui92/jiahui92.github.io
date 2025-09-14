## n8n
* crawl4ai
* [ ] http://host.docker.internal:11235/md
* [ ] http://localhost:11235/playground/
```sh
docker run -d -p 5678:5678 --name n8n -v n8n_data:/home/node/.n8n n8nio/n8n:latest
docker run -d -p 11235:11235 --name crawl4ai --shm-size=1g unclecode/crawl4ai:latest
```

* rsshub
* [ ] http://localhost:1200
* else
  * hackernews: https://hnrss.github.io/
  * producthubt: https://www.producthunt.com/feed
  * reddit: https://www.reddit.com/r/rss.rss
