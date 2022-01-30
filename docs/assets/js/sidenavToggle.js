var mediaQueryList = window.matchMedia("(min-width: 900px)");
var toggleNavTocButton = document.getElementsByClassName("navbar-toc-toggle-button")[0];
var navbarToc = document.getElementsByClassName("navbar-toc")[0];



const openNavbarToc = () =>{
  navbarToc.classList.toggle("hidden");
};


var keepOpen = false;

function handleViewPortWidthChange(mql) {
  if (mql.matches) {
    console.log("Page Changed")
    if (!(navbarToc.classList.contains("hidden"))) {
      openNavbarToc();
    }
  } 
}

handleViewPortWidthChange(mediaQueryList);

mediaQueryList.addEventListener("change", handleViewPortWidthChange);

toggleNavTocButton.onclick = openNavbarToc; 