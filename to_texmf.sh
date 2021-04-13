# Get script directory path: https://stackoverflow.com/a/4774063
SCRIPTPATH="$( cd "$(dirname "")" >/dev/null 2>&1 ; pwd -P )"

TEXHOME=$(kpsewhich -var-value=TEXMFHOME)
echo "1) Custom TeX directory: $TEXHOME"
echo ""
echo "2) Copy..."

PACKAGES="goodfellow_math custom_math custom_figs"

for package in $PACKAGES; do
    package_src="$SCRIPTPATH/latex/$package.sty"
    package_dst="$TEXHOME/tex/latex/$package"

    mkdir -vp $package_dst
    cp -v $package_src $package_dst
done

echo ""
echo "3) Update package index..."
texhash $TEXHOME

echo ""
echo "4) Verify..."

cd ~
for package in $PACKAGES; do
    package_texmf=$(kpsewhich $package.sty)
    echo "$package is in $package_texmf"
done
