```js
const email = 'example@rice.edu'
````

```js
const startUrl = `https://mail.google.com/mail/u/?authuser=${email}`;
const name = 'Rice&nbsp;GMail';
const description = 'Rice&nbsp;GMail';

document.head
  .querySelector(':first-child')
  .insertAdjacentHTML(
    'beforebegin',
    `<link rel="manifest" href='data:application/manifest+json,{"start_url":"${startUrl}", "name":"${name}", "description": "${description}", "icons": [{ "src": "https://github.com/jpslav/my_mac/raw/master/logos/gmail_rice_512.png", "type": "image/png", "sizes": "512x512" }, { "src": "https://github.com/jpslav/my_mac/raw/master/logos/gmail_rice_256.png", "type": "image/png", "sizes": "256x256" }, { "src": "https://github.com/jpslav/my_mac/raw/master/logos/gmail_rice_128.png", "type": "image/png", "sizes": "128x128" }]}' />`,
  );
```


