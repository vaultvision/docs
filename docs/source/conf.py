import sphinx_rtd_theme

# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'Vault Vision Documentation'
copyright = '2022, Vault Vision Inc.'
author = 'Vault Vision'

release = '1.1'
version = '1.1.0'

# -- General configuration

extensions = [
    'myst_parser',
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    'sphinx_rtd_theme',
    'sphinx_sitemap',
]

intersphinx_mapping = {
    'python': ('https://docs.python.org/3/', None),
    'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
}
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_rtd_theme'

# -- Options for EPUB output
epub_show_urls = 'footnote'

# -- option to display canonical URL link tag
html_baseurl = 'https://docs.vaultvision.com'

#option for sitemap
sitemap_url_scheme = "/{link}"
