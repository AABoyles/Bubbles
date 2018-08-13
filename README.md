# Bubbles

A Visualization of Groupings in the US HIV-Positive Population

## Data

The data are stored in [fakeinfectedpatients.csv](https://github.com/AABoyles/Bubbles/blob/master/fakeinfectedpatients.csv)

### Disclaimers

*All data are simulated. They do not represent any real person(s).*

Reasonable effort has been put in to creating a culturally-sensitive and
inclusive simulation of epidemiologically-relevant data. However, recognizing
that universal inclusivity is a tall mountain to climb, I am certain that I have
failed some groups in some ways. For this, I offer my most heartfelt apologies.
If you feel that I have failed to represent a group in a respectful way, please
[file an issue](https://github.com/AABoyles/Bubbles/issues/new) and I will
address it as soon as I am able to do so.

See also: [Known Oversights](https://github.com/AABoyles/Bubbles/labels/known%20oversight).

### Fields

* `Age at Diagnoses` - The age at which the patient was diagnosed. Distribution taken from the diagram "New HIV Diagnoses in the United State by Age, 2016" of [HIV in the United States: At A Glance](https://www.cdc.gov/hiv/statistics/overview/ataglance.html).
* `Sex at Birth` - Estimate taken from [Wikipedia: Human Sex Ratio](https://en.wikipedia.org/wiki/Human_sex_ratio)
* `Sexual Orientation` - Estimated from [HIV in the United States: At A Glance](https://www.cdc.gov/hiv/statistics/overview/ataglance.html)
* `Race` - Estimated from [HIV in the United States: At A Glance](https://www.cdc.gov/hiv/statistics/overview/ataglance.html)
* `Region` - Estimated from [HIV in the United States: At A Glance](https://www.cdc.gov/hiv/statistics/overview/ataglance.html)
* `PWID` (Person who Injects Drugs) - Estimated from [HIV in the United States: At A Glance](https://www.cdc.gov/hiv/statistics/overview/ataglance.html)
* `Viral Supression` - Estimated from [HIV in the United States: At A Glance](https://www.cdc.gov/hiv/statistics/overview/ataglance.html)
* `Gender` - Estimated from [HIV Among Transgender People](https://www.cdc.gov/hiv/group/gender/transgender/index.html)
* `MSM` (Men who have Sex with Men) - Derived as persons whose `Sex at Birth` is
coded as "Male" and whose `Sexual Orientation` is anything other than "Straight".
* `Transmission Category` - Derived as the groupings of `MSM`, `PWID`, Heterosexual
non-PWID (coded "HET"), and "Other" (e.g. Persons with Hemophilia who recieved
tainted transfusion products in the 1980's).
* `Risk Category` - Derived as the sum of the `MSM`, `PWID`, and `Viral Supression`
fields.

### Generation

The script used to generate fakeinfectedpatients.csv is also included. It's
called [spawnData.R](https://github.com/AABoyles/Bubbles/blob/master/spawnData.R).

Basically, it works in two passes. First, it selects demographics according to
CDC estimates. It does *not* attempt to account for correlations between these
factors (e.g. the population of African-Americans in the South is
disproportionately high.). Second, it generates additional demographic
information at the individual level which is, at least in part, derived from the
demographic data generated in the first step. For example, `Gender` is derived
from `Sex at Birth` along with the individual probability of transitioning
genders. Likewise, `MSM` is derived as people whose `Sex at Birth` is coded as
"Male" and whose `Sexual Orientation` is anything other than "Straight".
