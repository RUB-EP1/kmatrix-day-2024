from pathlib import Path
import shutil


def copy_julia_html_page() -> list[str]:
    html_page = Path("K-matrix.html")
    if html_page.exists():
        static_path = Path("_static")
        shutil.copy(html_page, static_path / html_page)
        return [str(static_path / html_page)]
    return []


BRANCH = "main"
ORGANIZATION = "RUB-EP1"
REPO_NAME = "kmatrix-day-2024"
copy_julia_html_page()

codeautolink_concat_default = True
exclude_patterns = [
    "**.ipynb_checkpoints",
    "*build",
]
extensions = [
    "myst_nb",
    "sphinx_codeautolink",
    "sphinx_copybutton",
    "sphinx_design",
    "sphinx.ext.intersphinx",
]
html_favicon = "_static/favicon.ico"
html_js_files = [
    "https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.6/require.min.js",
]
html_logo = "https://github.com/mmikhasenko/kmatrix-day-2024/assets/29308176/1a9db3dc-9398-4c7f-95f2-e46e68809a4d"
html_static_path = ["_static"]
html_theme = "sphinx_book_theme"
html_theme_options = {
    "icon_links": [
        {
            "icon": "https://indico.cern.ch/images/indico.ico",
            "name": "Indico",
            "type": "url",
            "url": "https://indico.cern.ch/event/1397619",
        },
        {
            "icon": "https://mybinder.readthedocs.io/en/latest/_static/favicon.png",
            "name": "Launch on Binder",
            "type": "url",
            "url": (
                f"https://mybinder.org/v2/gh/{ORGANIZATION}/{REPO_NAME}/{BRANCH}?filepath=docs"
            ),
        },
        {
            "icon": "https://avatars.githubusercontent.com/u/33467679?s=100",
            "name": "Launch on Colaboratory",
            "type": "url",
            "url": f"https://colab.research.google.com/github/{ORGANIZATION}/{REPO_NAME}/blob/{BRANCH}",
        },
        {
            "icon": "https://www.ruhr-uni-bochum.de/themes/custom/rub/favicon.ico",
            "name": "Ruhr University Bochum",
            "type": "url",
            "url": "https://www.ruhr-uni-bochum.de",
        },
        {
            "icon": "https://mmikhasenko.github.io/agmikhasenko/logo/ep1mikhasenko_logo_small.svg",
            "name": "Ruhr University Bochum",
            "type": "url",
            "url": "https://mmikhasenko.github.io/agmikhasenko",
        },
        {
            "icon": "https://compwa.github.io/_static/favicon.ico",
            "name": "Common Partial Wave Analysis",
            "type": "url",
            "url": "https://compwa.github.io",
        },
    ],
    "launch_buttons": {
        "binderhub_url": "https://mybinder.org",
        "colab_url": "https://colab.research.google.com",
        "notebook_interface": "jupyterlab",
    },
    "logo": {"text": "International K-matrix day 2024"},
    "path_to_docs": "docs",
    "repository_branch": BRANCH,
    "repository_url": f"https://github.com/{ORGANIZATION}/{REPO_NAME}",
    "show_toc_level": 2,
    "use_download_button": True,
    "use_edit_page_button": True,
    "use_issues_button": True,
    "use_repository_button": True,
    "use_source_button": True,
}
intersphinx_mapping = {
    "ampform": ("https://ampform.readthedocs.io/0.15.8", None),
    "IPython": ("https://ipython.readthedocs.io/en/9.0.2", None),
    "ipywidgets": ("https://ipywidgets.readthedocs.io/en/8.1.5", None),
    "matplotlib": ("https://matplotlib.org/3.10.0", None),
    "numba": ("https://numba.readthedocs.io/en/0.60.0", None),
    "numpy": ("https://numpy.org/doc/1.26", None),
    "plotly": ("https://plotly.com/python-api-reference/", None),
    "python": ("https://docs.python.org/3.12", None),
    "sympy": ("https://docs.sympy.org/latest", None),
}
myst_enable_extensions = [
    "amsmath",
    "colon_fence",
    "dollarmath",
    "smartquotes",
]
myst_heading_anchors = 2
nb_execution_allow_errors = False
nb_execution_mode = "cache"
nb_execution_show_tb = True
nb_execution_timeout = -1
nb_output_stderr = "remove"
project = "International K-matrix day 2024"
suppress_warnings = [
    "mystnb.unknown_mime_type",
]
