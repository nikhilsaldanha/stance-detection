# stance-detection

Implementation of the paper "Emergent: a novel data-set for stance classification"

## Setting up for Development

1. Make a virtual environment using virtualenv: `virtualenv -p python3 env`
2. Activate it when running python scripts: `source env/bin/activate` (to deactivate, run `deactivate`).
3. Install required dependencies: `pip install -r requirements.txt`
4. Download Emergent Data from [here](https://drive.google.com/folderview?id=0BwPdBcatuO0vYTAxSnA1d09qdGM&usp=sharing) into `data/`
5. Download the PPDB data from [paraphrase.org](http://paraphrase.org/#/download)
6. Run [notebooks/create_ppdb_dict.ipynb](notebooks/create_ppdb_dict.ipynb) to parse PPDB and convert it to a dictionary form
