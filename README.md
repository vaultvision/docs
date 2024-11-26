# Developer Docs - [Vault Vision](https://vaultvision.com) 

This is the repository for the user authentication developer documentation hosted at [https://docs.vaultvision.com](https://docs.vaultvision.com).


## Quick Start


```bash
make build
```


#### prerequisites (Ubuntu)
- python
- pip
- venv

```bash
apt-get install -y python3
apt-get install -y python3-pip
apt-get install -y python3-venv
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
```

## Windows Setup

Install python3, pip and venv
From the project root folder, create the .venv and install requirements and create the build folder and run the build command
```bash
python -m venv .venv
.venv/Scripts/pip install -r requirements.txt
rm -rf docs/build && mkdir docs/build && mkdir docs/build/html
.venv/Scripts/sphinx-build docs/source docs/build/html
sed -i 's|<body class="wy-body-for-nav">|<body class="wy-body-for-nav matomo"><img referrerpolicy="no-referrer-when-downgrade" src="https://vaultvision.matomo.cloud/matomo.php?idsite=6\&rec=1" style="border:0;position: absolute;" alt="" />|g' $(find docs/build/html -type f -name '*.html')
(optional command to run a local http server to verify)
.venv/Scripts/python.exe -m http.server --bind localhost --directory docs/build/html 8080

```


## Image Setup

To add black borders to images:

```bash
for x in *.png; do
    ffmpeg -i "${x}" \
      -vf "pad=width='iw+4':height='ih+4':x='2':y='2':color=black" \
      "../${x}"
done
```

## Notes

The directives for sphinx are declared in markdown format as shown below:

RST:
```
.. toctree::
   :maxdepth: 2

   intro
   strings
   datatypes
   numeric
   (many more documents listed here)
```

Markdown:
```
\`\`\`{toctree}
   :maxdepth: 2

   intro
   strings
   datatypes
   numeric
   (many more documents listed here)
\`\`\`
```

Supports any RST:
```
\`\`\`{eval-rst}
.. toctree::
   :maxdepth: 2

   intro
   strings
   datatypes
   numeric
   (many more documents listed here)
\`\`\`
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
https://sphinx-toolbox.readthedocs.io/en/stable/index.html
https://docs.readthedocs.io/en/stable/guides/migrate-rest-myst.html
