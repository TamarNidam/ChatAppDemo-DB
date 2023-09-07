import os
import csv
import base64
from flask import Flask, render_template, request, redirect, session
from flask_session import Session
from datetime import datetime


app = Flask(__name__, template_folder='templates')
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
app.secret_key = os.urandom(24)
Session(app)


room_arr = []

@app.route("/logout")
def logout():
    session["userName"] = None
    return redirect("/")



@app.route("/", methods=['GET', 'POST'])
def register():
  if request.method == "POST":
   session["userName"] = request.form.get("username")
   session["userPassword"] = request.form.get("password")
   if checkExsist(session.get("userName"), session.get("userPassword")):
     return redirect("lobby") 
   else:
    return redirect("logIn") 
  return render_template('register.html')
  

@app.route("/lobby", methods=['GET', 'POST'])
def room():
  if request.method == 'POST':
     roomName=request.form.get("new_room")
     room_path = "rooms/{}.txt".format(roomName)
     if roomName in room_arr:
      return "the name is alerady exsist" 
     else:
      room_arr.append(roomName)
      with open(room_path, 'w') as f:
        f.write("{}\n".format(roomName))  
      session["roomName"]=roomName          
  return render_template('lobby.html',room_names = room_arr)


@app.route('/chat/<room>', methods=['GET','POST'])
def chat(room):
  return render_template('chat.html', room=room)

@app.route('/api/chat/<room>', methods=['GET','POST'])
def api_chat(room): 
    if request.method == 'GET':
     with open("rooms/{}.txt".format(room), 'r') as file:
      file.seek(0)
      lines = file.read()
      return lines
    elif request.method == 'POST':
      message = request.form.get("msg")
      timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
      with open("rooms/{}.txt".format(room), "a") as ifile:
       ifile.write(f'{timestamp} - {session.get("userName")} - {message}\n')
       lines = file.read()
      return lines

@app.route("/api/chat/<room>/clear_messages", methods=['GET', 'POST'])
def clear_messages(room):
    open(f'rooms/{room}.txt', 'w').close()
    return redirect("/chat/"+room)

  
@app.route("/logIn",methods=['GET','POST'])
def login():
  if request.method == "POST":
   session["userName"] = request.form.get("username")
   session["userPassword"] = request.form.get("password")
   encode_psw=encode(session.get("userPassword"))
   row1 = [session.get("userName"), encode_psw]
   with open('users.csv', 'w') as f:
    writer = csv.writer(f)
    writer.writerow(row1)
   return redirect("lobby") 
  return render_template('login.html')

@app.route("/health")
def health(): 


def encode(psw):
   pws_bytes = psw.encode('ascii')
   base64_bytes = base64.b64encode(pws_bytes)
   base64_psw = base64_bytes.decode('ascii')
   return base64_psw


def decode(psw):
 base64_bytes = psw.encode('ascii')
 pws_bytes = base64.b64decode(base64_bytes)
 psw = pws_bytes.decode('ascii')
 return psw


def checkExsist(name,psw):
  with open("users.csv", 'r') as file:
    csvreader = csv.reader(file)
    for row in csvreader:
      if row[0] == name:
         encrypted_password = row[1]
         password=decode(encrypted_password)
         if password == psw:
          return True
  return False


if __name__ == "__main__":
 app.run(host='0.0.0.0', port="5000", debug='True')

