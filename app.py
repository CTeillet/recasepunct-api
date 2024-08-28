from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route('/recasepunc', methods=['POST'])
def recasepunc_api():
    # Obtenir le texte envoyé dans la requête POST
    text = request.json.get('text', '')

    # Définir le chemin complet du script recasepunc.py et du modèle
    script_path = os.path.join('/app/recasepunc', 'recasepunc.py')
    checkpoints_path = os.getenv('MODEL_PATH')  # Utiliser la variable d'environnement définie dans Docker

    # Appeler recasepunc.py en tant que sous-processus
    process = subprocess.Popen(
        ['python', script_path, 'predict', checkpoints_path, '--lang', 'fr'],  # Utilisation correcte du script avec les arguments
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    stdout, stderr = process.communicate(input=text.encode('utf-8'))

    if process.returncode != 0:
        return jsonify({'error': stderr.decode('utf-8')}), 500

    # Retourner le texte formaté
    formatted_text = stdout.decode('utf-8')
    return jsonify({'formatted_text': formatted_text})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
