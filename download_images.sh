#!/usr/bin/env bash
# Downloads every image used on the Hope For A Change site into ./images/
# Run from the folder that contains index.html:  bash download_images.sh
mkdir -p images
B="https://static.wixstatic.com/media"
fail=0

# dl <local name> <wix media id> [<exact URL the live site used, as fallback>]
dl() {
  echo "-> images/$1"
  if curl -fsSL "$B/$2" -o "images/$1"; then return 0; fi
  if [ -n "$3" ] && curl -fsSL "$3" -o "images/$1"; then echo "   (used fallback URL)"; return 0; fi
  echo "   !! could not download $1"; rm -f "images/$1"; fail=1
}

dl home-why-hope.png       84770f_b25341fba0ec4e6591393061cf5cef8e.png "$B/84770f_b25341fba0ec4e6591393061cf5cef8e.png/v1/fill/w_105,h_110,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/84770f_b25341fba0ec4e6591393061cf5cef8e.png"
dl home-photographic.png   84770f_ff41be4acfd7452588a06cf63ef9416d.png "$B/84770f_ff41be4acfd7452588a06cf63ef9416d.png/v1/fill/w_105,h_105,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/84770f_ff41be4acfd7452588a06cf63ef9416d.png"
dl home-about-project.png  84770f_015d1b7456f64adf987554bc673876c0.png "$B/84770f_015d1b7456f64adf987554bc673876c0.png/v1/fill/w_105,h_105,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/84770f_015d1b7456f64adf987554bc673876c0.png"
dl gallery-1.png           "dee289_992eb48c4a0f4437a7385c738169ec69~mv2.png" "$B/dee289_992eb48c4a0f4437a7385c738169ec69~mv2.png/v1/fill/w_650,h_372,al_c,q_85,enc_avif,quality_auto/dee289_992eb48c4a0f4437a7385c738169ec69~mv2.png"
dl gallery-2.jpg           "dee289_41c8944346b44057942a86ddc144e909~mv2.jpg" "$B/dee289_41c8944346b44057942a86ddc144e909~mv2.jpg/v1/fill/w_570,h_430,al_c,q_80,enc_avif,quality_auto/dee289_41c8944346b44057942a86ddc144e909~mv2.jpg"
dl gallery-3.jpg           "dee289_62290e280d5943de8c1da923d312159a~mv2.jpg" "$B/dee289_62290e280d5943de8c1da923d312159a~mv2.jpg/v1/fill/w_700,h_394,al_c,q_80,enc_avif,quality_auto/dee289_62290e280d5943de8c1da923d312159a~mv2.jpg"
dl photographic-banner.jpg "dee289_16a1677ef5fb4db8a691320d6759d284~mv2_d_1325_2048_s_2.jpg"
dl peace-and-safe.png      214ec6_a3252f4103b863ceeba46690fbacebda.png "$B/214ec6_a3252f4103b863ceeba46690fbacebda.png/v1/fill/w_120,h_120,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/214ec6_a3252f4103b863ceeba46690fbacebda.png"
dl about-me.jpg            "dee289_b862d6e9a4284a1c9eb24c5e3b781f25~mv2.jpg"
dl about-project.jpg       "dee289_772885a414184dc0a03c769e8b835002~mv2.jpg" "$B/dee289_772885a414184dc0a03c769e8b835002~mv2.jpg/v1/fill/w_660,h_458,al_c,lg_1,q_80,enc_avif,quality_auto/dee289_772885a414184dc0a03c769e8b835002~mv2.jpg"


# PDFs (research paper + statement of purpose) -> ./files/
mkdir -p files
dlf() {
  echo "-> files/$1"
  if ! curl -fsSL "$2" -o "files/$1"; then echo "   !! could not download $1"; rm -f "files/$1"; fail=1; fi
}
dlf research-paper.pdf                      https://docs.wixstatic.com/ugd/dee289_59874ab821fd4effb33056f0f9518d48.pdf
dlf research-statement-of-purpose.pdf       https://docs.wixstatic.com/ugd/dee289_1d5cfc0de96344fe90ef6b62a23a4a5f.pdf

if [ "$fail" = 0 ]; then echo "Done. All 10 images saved to ./images/ and 2 PDFs saved to ./files/"; else echo "Finished with some failures (see !! above)."; fi
