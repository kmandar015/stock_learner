/// Sentry DNS is used to track errors. It is beeing used at [SentryHelper].
/// To get your DNS, go to: https://sentry.io/.
/// Create a project and follow these steps: https://forum.sentry.io/t/where-can-i-find-my-dsn/4877
/// pass == ksentryDNSAPIKey@123
const String kSentryDomain =
    "https://7cf357ff518d27535145a47276655ed0@o4508041550692352.ingest.us.sentry.io/4508041552986112";

/// The Alpha Vantage API is used to power the Search Section.
/// It is used at [SearchClient].
/// To get your own API key go to: https://www.alphavantage.co.
const String kAlphaVantage = "138MGOXPO297LR6U";

/// The Finnhub Stock API is used to power the news section in the [ProfileSection] page.
/// It is used at [ProfileClient].
/// To get your own API key go to: https://finnhub.io.
/// Pass Web site == kAlphaVantageKey
const String kFinnhub = "crt8e9hr01qpjadus1f0crt8e9hr01qpjadus1fg";

/// The News API is used to power the news section.
/// It is used at [NewsClient].
/// To get your own API key go to: https://newsapi.org.
/// Same pass == kNewsApiKey
const String kNews = "53a0a8ee66664a1cb147326cd12fea45";

/// Financial Modeling Prep API is used to power the Home, U.S Market and Profile Section.
/// Now an API key is required which means that we won't be able to make infinite requests. :(
/// To get your own API key go to: https://financialmodelingprep.com/developer/docs/
/// pass == kfinancialAPIKey@123
const String kFinancialModelingPrep = "zA6cOhVfWHbkDRfzi2t7in0mkQ2pKTDU";
