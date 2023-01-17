# Documentation - Vault Vision

This is the repository for the user authentication developer documentation hosted at [https://docs.vaultvision.com](https://docs.vaultvision.com).


## Quick Start


```bash
make build
```

Configure app [.env](.env.defaults) file:
```
cp .env.defaults .env
vi .env  # Set your VV_ISSUER_URL
```

Run the example on localhost:
```bash
npm run dev
```

Visit [http://localhost:8090](http://localhost:8090) in your browser.


## Image Setup

To add black borders to images:

```bash
for x in *.png; do
    ffmpeg -i "${x}" \
      -vf "pad=width='iw+4':height='ih+4':x='2':y='2':color=black" \
      "../${x}"
done
```


## Who are we?

[Vault Vision](https://vaultvision.com) is a user authenticaiton and login management platform whose passwordless technology is powered by the most secure authentication protocols and easier authentication system integration for startup developers, IT security teams and seamless security for end users.

Visit [https://docs.vaultvision.com](https://docs.vaultvision.com) to learn more!


----

Vault Vision projects adopt the [Contributor Covenant Code of Conduct](https://github.com/vaultvision/.github/blob/main/CODE_OF_CONDUCT.md) and practice responsible disclosure as outlined in our [Security Policy](https://github.com/vaultvision/.github/blob/main/SECURITY.md).


#### Reference Links

https://myst-parser.readthedocs.io/en/latest/syntax/optional.html
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html
https://markdown-it.github.io/
https://www.sphinx-doc.org/en/master/usage/markdown.html
https://sphinx-tutorial.readthedocs.io/cheatsheet/
