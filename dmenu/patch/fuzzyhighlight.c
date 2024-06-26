static void
drawhighlights(struct item *item, char *output, int x, int y, int maxw)
{
	int i, indent;
	char *highlight;
	char c;

	char *itemtext = output;

	if (!(strlen(itemtext) && strlen(text)))
		return;

	/* Do not highlight items scheduled for output */
	if (issel(item->id))
		return;

	drw_setscheme(drw, scheme[item == sel
	                   ? SchemeSelHighlight
	                   : SchemeNormHighlight]);
	for (i = 0, highlight = itemtext; *highlight && text[i];) {
		if (!fstrncmp(&(*highlight), &text[i], 1))
		{
			/* get indentation */
			c = *highlight;
			*highlight = '\0';
			indent = TEXTW(itemtext) - lrpad;
			*highlight = c;

			/* highlight character */
			c = highlight[1];
			highlight[1] = '\0';
			drw_text(
				drw,
				x + indent + (lrpad / 2),
				y,
				MIN(maxw - indent - lrpad, TEXTW(highlight) - lrpad),
				bh, 0, highlight, 0
			);
			highlight[1] = c;
			i++;
		}
		highlight++;
	}
}
