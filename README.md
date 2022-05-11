# Welcome to the Binghamton University Spiedie Documentation

This README is intended to provide insight into updating and expanding upon the documentation. 

## Root Directory Tree

```bash
├── CNAME
├── Gemfile
├── Gemfile.lock
├── Gemfile~
├── README
├── _config.yml
├── index.html
├── tags.html
├── _data
│   └── ...
├── _includes
│   ├── ...
├── _layouts
│   └── ...
├── _sass
│   ├── ...
├── _site
│   ├── ...
├── assets
│   ├── ...
├── docs
│   ├── ...
├── download
│   ├── ...
├── singularity
│   ├── ...
├── tutorials
│   ├── ...
```

## Root Directory files

### CNAME

The CNAME file is used when using a custom domain name in github pages. It contains the custom domain name chosen and is used for redirects.

*The CNAME file doesn't need to be altered under normal documentation updates*

### Gemfile/Gemfile.lock
The Gemfile contains the information that ruby needs to run the Jekyll application. It instructs on what version of Jekyll to use as well as the themes and build processes.

The Gemfile.lock contains all the information about which dependencies are used in the Jekyll application.

*These files also don't need to be altered. Some modification may be needed when downloading and running the application on a personal computer. Information on building and running Jekyll can be found [here](https://jekyllrb.com/).*

### _config.yml

This file contains further customization on how to build the Jekyll site. You can learn more about this file ]here](https://jekyllrb.com/docs/configuration/)

*Normally doesn't need to be altered*

### index.html

This is the first page that is loaded up when visiting [spiediedocs.binghamton.edu](spiediedocs.binghamton.edu).

*Change this depending on your needs*

### tags.html

This contains the tags used throughout the site, as well as the corresponding documentation.

*This page should auto-update when new tags are created in the front matter of doc pages.*

## Root Directory Folders

### _data

```bash
├── _data
│   └── toc.yaml
```
From the Jekyll website.

> The ```_data``` folder is where you can store additional data for Jekyll to use when generating your site. These files must be YAML, JSON, TSV or CSV files (using either the .yml, .yaml, .json, .tsv, or .csv extension), and they will be accessible via site.data.

#### toc.yaml

This file contains the information needed to generate the table of contents. When adding/removing/re-organizing pages in the documentation be sure to update this file. 

The structure of the *toc.yaml* is as follows:

```yaml
toc:
  - title: Section Title
    category: section-category
    contents:
      - title: Sub-section Title
        url: link/to/sub-section-resource
        external: true/false
        inner_contents:
          - title: Sub-sub-section Title
            url: link/to/sub-sub-section-resource
            external: true/false
      

```

The layout here is straight-forward.

| Label|Description|
|***|***|
|title| The title of the section.|
|category| The section category. Used mainly for top level sections.|
|contents| The contents of the top level sections.|
|url| The link to the resource. Can be an external url (i.e. https://www.binghamton.edu) or local url (i.e. "/docs/basic_slurm_commands.html"). Quotes must be included for local connection.|
|external| Can be true or false. This sets the target attribute for links so that external links open in a new tab.| 
|inner-contents| The contents of the sub-section.|

This *toc.yaml* file goes hand in hand with the *_includes/table_of_contents.html* file. Changes to either must be in coordination with changes in the other.

### _includes

```bash
├── _includes
│   ├── docs-nav.html
│   ├── table_of_contents.html
│   └── taglist.html
```

This folder contains code snippets to be used in other files. It is used primarily for separation of concerns, simplifying the html structure in other files. 

| File|Description|
|***|***|
|docs-nav.html| The html responsible for the breadcrumb navigation at the top of the documentation pages.|
|table_of_contents.html| The html responsible for generating the table of contents. |
|taglist.html| The html responsible for generating the tag list.|

These files are used in other html files, such as *_layouts/default.html*. To include these in other files you can use the ```{% include something.html %}``` tag where you want to include the files.

### _layouts

```bash
├── _layouts
│   └── default.html
```

This folder contains the general layout of the pages. The file *default.html* is the default layout of the documentation. Changes to this file will affect the layout of the entire documentation.

### _sass

```bash
├── _sass
│   ├── base.scss
│   ├── content-detail.scss
│   ├── content.scss
│   ├── global.scss
│   ├── index.scss
│   ├── main.scss
│   ├── mixins.scss
│   ├── navbar.scss
│   ├── normalize.scss
│   ├── sidenav.scss
│   └── variables.scss
```

This folder contains the *.scss* files. Jekyll takes these files and compiles them into normal css which is then used in the site. Each *.scss* defines the styles for distinct components of the documentation, such as the navbar or table of contents. This allows for cleaner code writing. 

### _site
This folder contains the generated html for the documentation. After Jekyll generates the static site it places the files in this folder.

*Normally there is no reason to make any edits to the files in this folder*

### assets
```bash
├── assets
│   ├── css
│   │   ├── bingfont.css
│   │   ├── default.scss
│   │   ├── defaultt.css
│   │   └── pygments.css
│   ├── fonts
│   │   └── RobotoSlab-VariableFont_wght.ttf
│   ├── images
│   │   ├── connecting-to-spiedie
│   │   ├── data-transfer
│   │   ├── user-directory
│   │   ├── using-resources
│   │   ├── Screen\ Shot\ 2022-02-03\ at\ 8.27.54\ AM.png
│   │   └── favicon.ico
│   └── js
│       ├── jquery.autocomplete.js
│       └── sidenavToggle.js
```


