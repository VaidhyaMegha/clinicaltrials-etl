from lxml import html
from urllib2 import urlopen
from pysqlite2 import dbapi2 as sqlite

def get_trials():
    return xrange(1, 330000)

def get_trial(ref):
    base = "https://www.anzctr.org.au/Trial/Registration/TrialReview.aspx?id="
    return html.parse(urlopen(base + str(ref))).getroot()

def do_trial(ref):
    trial = get_trial(ref)
    try:
        rows = trial.cssselect('div.review-form-block')
    except TypeError:
        # occasionally, get_trial returns None
        rows = []
    for row in rows:
        rowid=''
        extras = ''
        if 'id' in row.attrib:
            rowid=row.attrib['id']
        elif 'class' in row.attrib:
            rowid=row.attrib['class']

        if 'style' in row.attrib and 'DISPLAY: none' in row.attrib['style']:
            extras = 'hidden'
        
        try:
            row = rowid, row[0].text_content().strip(), row[1].text_content().strip(), extras
            print row
            yield row
        except Exception, e:
            print e
            pass

con = sqlite.connect(":memory:", detect_types=sqlite.PARSE_COLNAMES)
cur = con.cursor()

# done = set([res['trial_id'] for res in cur.execute('select trial_id FROM _raw')])
for trial in get_trials():
    # if trial not in done:
    data = [row for row in do_trial(trial)]
    print data
        # pysqlite2.save(['trial_id'], dict(trial_id=trial, data=data), table_name='_raw')