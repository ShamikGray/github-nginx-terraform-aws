from flask import Flask, jsonify, request
import requests
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(filename='app.log', level=logging.ERROR)

# Endpoint to retrieve IP information
@app.route('/vend_ip')
def vend_ip():
    try:
        # Call the REST API to retrieve IP information
        response = requests.get('http://169.254.169.254/latest/meta-data/network/interfaces/macs/')
        response.raise_for_status()  # Raise an exception for non-2xx responses
        
        mac_address = response.text.strip()
        subnet_ip_response = requests.get(f'http://169.254.169.254/latest/meta-data/network/interfaces/macs/{mac_address}/subnet-ipv4-cidr-block')
        subnet_ip_response.raise_for_status()  # Raise an exception for non-2xx responses
        
        subnet_ip = subnet_ip_response.text.strip()
        subnet_ip_addr = subnet_ip.split('/')[0]
        subnet_size = subnet_ip.split('/')[1]    
        data = {
            "ip_address": subnet_ip_addr,
            "subnet_size": f"/{subnet_size}"
        }
        return jsonify(data)
    except Exception as e:
        # Log the error
        logging.error(f'Error occurred while retrieving IP information: {str(e)}')
        # Return an error response
        return jsonify({"error": "An error occurred while retrieving IP information"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
