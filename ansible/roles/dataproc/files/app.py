import argparse
import http.server
import socketserver

# FIX: the entrypoint runs "app.py api --port 5000". The original read the port
# from sys.argv[2], which is the string "--port", so int() crashed on startup.
# Parse the arguments by name instead of by position.
parser = argparse.ArgumentParser()
parser.add_argument("mode", nargs="?", default="api")
parser.add_argument("--port", type=int, default=5000)
args = parser.parse_args()

PORT = args.port
Handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving at port {PORT}", flush=True)
    httpd.serve_forever()
