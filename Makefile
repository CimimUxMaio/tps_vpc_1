# opencv-python wheels ship a Qt backend but not its fonts. On Linux, Qt looks
# for fonts in cv2/qt/fonts (set via QT_QPA_FONTDIR in cv2/config-3.py) and
# prints "QFontDatabase: Cannot find font directory" warnings if that dir is
# empty/missing. Deploy the system's DejaVu fonts there to silence the warning.
fonts:
	@FONTS_DIR="$$(uv run python -c 'import cv2, os; print(os.path.join(os.path.dirname(cv2.__file__), "qt", "fonts"))')"; \
	mkdir -p "$$FONTS_DIR"; \
	ln -sf /usr/share/fonts/truetype/dejavu/*.ttf "$$FONTS_DIR"/; \
	echo "Fonts deployed to $$FONTS_DIR"

lab: fonts
	uv run jupyter lab
