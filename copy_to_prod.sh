#!/bin/bash
echo ----- Job started: copy_to_prod.sh -------------------------------------------------

if [ ! -d "../FlaskMinimalWebapp_prod" ]; then
	echo INFO: FlaskMinimalWebapp_prod folder absent, cloning
	git clone https://KRC2000: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@github.com/KRC2000/FlaskMinimalWebapp_prod.git ..
fi

rsync -am --include='*/' --exclude='*.sh' --exclude='Dockerfile' --exclude='.dockerignore' --exclude='*.md' --exclude='endpoint.js' ../FlaskMinimalWebapp_dev/ ../FlaskMinimalWebapp_prod/

echo ----- Job finished: copy_to_prod.sh -------------------------------------------------
