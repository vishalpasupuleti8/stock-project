from flask import Flask, render_template, request
import requests

app = Flask(__name__)

@app.route('/')
def index():
    # Replace 'YOUR_API_KEY' with your actual Polygon.io API key
    api_key = '6Ut9vSrTMBSXbmWpfc8UhVbZAWpddD7z'
    stock_symbols = ['AAPL', 'MSFT', 'GOOGL', 'FB', 'AMZN', 'TSLA', 'NFLX']  # Example list of stock symbols

    stock_data = {}
    for symbol in stock_symbols:
        stock_data[symbol] = get_stock_price(symbol, api_key)

    return render_template('index.html', stock_data=stock_data)

def get_stock_price(symbol, api_key):
    url = f"https://api.polygon.io/v2/aggs/ticker/{symbol}/prev?adjusted=true&apiKey={api_key}"
    response = requests.get(url)
    if response.status_code == 200:
        try:
            data = response.json()
            price = data['results'][0]['c']
            return price
        except (KeyError, IndexError):
            print(f"Error parsing response for {symbol}: {response.text}")
    else:
        print(f"Error fetching data for {symbol}: Status code {response.status_code}")
    return None

if __name__ == '__main__':
    app.run(debug=False)  # Set debug mode to False
