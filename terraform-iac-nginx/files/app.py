from flask import Flask, jsonify, request
import requests

app = Flask(__name__)

# Endpoint to retrieve IP information
@app.route('/vend_ip')
def vend_ip():
    # Call the REST API to retrieve IP information
    response = requests.get('http://169.254.169.254/latest/meta-data/network/interfaces/macs/')
    mac_address = response.text.strip()
    
    subnet_ip_response = requests.get(f'http://169.254.169.254/latest/meta-data/network/interfaces/macs/{mac_address}/subnet-ipv4-cidr-block')
    subnet_ip = subnet_ip_response.text.strip()
    
    # "192.168.0.0/16" in this format
    subnet_ip_addr = subnet_ip.split('/')[0]
    subnet_size = subnet_ip.split('/')[1]    
    data = {
        "ip_address": subnet_ip_addr,
        "subnet_size": f"/{subnet_size}"
    }

    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


