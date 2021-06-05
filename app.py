from flask import Flask, render_template, url_for, redirect, request, copy_current_request_context
from flask_wtf import CSRFProtect
from flask import flash, session
from config import DevelopmentConfig
from models import database, login_manager
from models import RegistrosSyP, empresa, Admin, Education, Course, Publication, Volunteering, Experience, Language
import forms
from flask_mail import Mail, Message
import threading
import os
from werkzeug.utils import secure_filename
from datetime import timedelta
import json

app = Flask(__name__)
app.config.from_object(DevelopmentConfig)
csrf = CSRFProtect()
app.config['UPLOAD_FOLDER'] = './static/img/profile'
mail = Mail()


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@app.before_request
def before_request():
    session.permanent = True
    app.permanent_session_lifetime = timedelta(minutes=30)
    direcc = ['admin','inicio', 'perfil', 'edit_education', 'edit_course', 'edit_publication', 'edit_volunteering', 'edit_experience', 'edit_language', 'delete_education', 'delete_course', 'delete_publication', 'delete_volunteering', 'delete_experience', 'delete_language', 'perfil_fil', 'perfil_rec', 'Minas', 'Ambiental', 'Geologia', 'Petroleos', 'seleccion'] # Inicio
    direcc3 = ['home','inicio', 'login', 'register', 'registercompany', 'forgotpass', 'resetpass', 'admin', 'perfil_fil', 'perfil_rec', 'Minas', 'Ambiental', 'Geologia', 'Petroleos', 'seleccion'] # Panel Usuario
    direcc2 = ['login', 'register', 'home', 'admin', 'perfil', 'edit_education', 'edit_course', 'edit_publication', 'edit_volunteering', 'edit_experience', 'edit_language', 'delete_education', 'delete_course', 'delete_publication', 'delete_volunteering', 'delete_experience', 'delete_language'] # Panel Empresa
    direcc4 = ['login', 'register', 'registercompany', 'forgotpass', 'resetpass', 'home', 'perfil', 'edit_education', 'edit_course', 'edit_publication', 'edit_volunteering', 'edit_experience', 'edit_language', 'delete_education', 'delete_course', 'delete_publication', 'delete_volunteering', 'delete_experience', 'delete_language', 'inicio', 'perfil_fil', 'perfil_rec', 'Minas', 'Ambiental', 'Geologia', 'Petroleos', 'seleccion'] # Panel Administrador
    if 'username' not in session and request.endpoint in direcc:
        return redirect(url_for('login'))
    elif 'username' in session:
        username = session['username']
        dataa = Admin.query.filter_by(admin = username).first()
        datat = RegistrosSyP.query.filter_by(username = username).first()
        datac = empresa.query.filter_by(empresa = username).first()
        if dataa is not None:
            if dataa.rol == 'admin' and request.endpoint in direcc4:                     
                return redirect(url_for('admin', username = username))
        elif datac is not None:
            if datac.rol == 'empresa' and request.endpoint in direcc2:                     
                return redirect(url_for('inicio', username = username))
        elif datat is not None:        
            if datat.rol == 'user' and request.endpoint in direcc3:          
                return redirect(url_for('perfil', username = username))

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if datat is None:
            return redirect(url_for('App.home'))
        return view(**kwargs)
    return wrapped_view

def send_email(user_email, firstname, username):
    msg = Message('Gracias por tu registro!', 
                    sender = app.config['MAIL_USERNAME'],
                    recipients = [user_email])
    msg.html = render_template('emailr.html', firstname = firstname, username = username)
    mail.send(msg) 

@app.route('/')
def home():
    return render_template('index/portada.html')

@app.route('/about_us')
def about():
    return render_template('index/about_us.html')

@app.route('/admin', methods = ['GET', 'POST'])
def admin():
    username = session['username']
    user = database.session.query(Admin).filter_by(admin = username).first()
    carreras = database.session.query(RegistrosSyP).all()
    empresas = database.session.query(empresa).all()
    return render_template('admin/admin.html', user = user, username = username, carreras = carreras, empresas = empresas)

@app.route('/fil', methods = ['GET', 'POST'])
def fil():
    username = session['username']
    user = database.session.query(Admin).filter_by(admin = username).first()
    carreras = database.session.query(RegistrosSyP).all()
    empresas = database.session.query(empresa).all()
    return render_template('company/fil.html', user = user, username = username, carreras = carreras, empresas = empresas)


@app.route('/register', methods = ['GET', 'POST'])
def register():
    reg_form = forms.RegisForm(request.form)
    if request.method == 'POST' and  reg_form.validate():
        user = RegistrosSyP(reg_form.firstname.data, reg_form.lastname.data, reg_form.username.data,  reg_form.email.data, reg_form.password.data, reg_form.career.data,  rol = "user", photo="u")
        database.session.add(user)
        database.session.commit()
        
        @copy_current_request_context
        def send_message(email, firstname, username):
            send_email(email, firstname, username)

        sender = threading.Thread(name = 'mail_sender', 
                                    target=send_message, 
                                    args=(user.email, user.firstname, user.username)
                                    )
        sender.start()


        success_message = 'Usuario Registrado'
        flash(success_message)
        return redirect(url_for('login'))
    return render_template('registro/auth-sign-up.html', form = reg_form)

@app.route('/6d81b1823d34e69143165ba999d33ba2e47a23210135ed27e4dc73f5bd655b4ed337c78ef9070f3d45209075fb6887c36edb99c90383a5b9a4777bc87ff8b143', methods = ['GET', 'POST'])
def registercompany():
    company_form = forms.Empresas(request.form)
    if request.method == 'POST' and  company_form.validate():
        comp = empresa(company_form.empresa.data,  company_form.email.data, company_form.password.data, rol = "empresa")
        database.session.add(comp)
        database.session.commit()
        @copy_current_request_context
        def send_message(email, empresa):
            send_email(email, empresa)

        sender = threading.Thread(name='mail_sender', target= send_message, args=(comp.email, comp.empresa))
        sender.start()
        success_message = 'Usuario Registrado'
        flash(success_message)
        return redirect(url_for('login'))
    return render_template('company/register_company.html', form = company_form)
    


@app.route('/login', methods = ['GET', 'POST'])
def login():
    login_form = forms.LoginForm(request.form)

    if request.method == 'POST' and login_form.validate():        
        username = login_form.username.data        
        password = login_form.password.data

        user = RegistrosSyP.query.filter_by(username = username).first()
        comp = empresa.query.filter_by(empresa = username).first()
        adm = Admin.query.filter_by(admin = username).first()

        if adm is not None:
            session['username'] = username
            return redirect(url_for('admin'))
        elif comp is not None and comp.verify_password(password):
            session['username'] = username
            return redirect(url_for('inicio', username = username))
        elif user is not None and user.verify_password(password):
            session['username'] = username
            return redirect(url_for('perfil', username = username))          
        else:
            error_message = 'Usuario o contraseña incorrecta'
            flash(error_message)       

    return render_template('registro/auth-normal-sign-in.html', form = login_form)


@app.route('/forgotpass', methods = ['GET', 'POST'])
def forgotpass():
    forgot_form = forms.RequestResetForm(request.form)
    if request.method == 'POST' and forgot_form.validate():
        email = forgot_form.email.data
        user = RegistrosSyP.query.filter_by(email = email).first()
        if user is not None:
            token = user.get_reset_token()
            msg = Message('Password Reset Request', sender=app.config['MAIL_USERNAME'], recipients = [user.email])
            msg.html = render_template('reset_email.html', user=user, token=token)
            mail.send(msg)
            flash('Un email fue enviado a la direccion de correo electronico')
            return redirect (url_for('login'))
    return render_template('registro/forgot_password.html',  form = forgot_form)

@app.route('/resetpass/<token>', methods = ['GET', 'POST'])
def resetpass (token):
    user = RegistrosSyP.verify_reset_token(token)
    if user is None:
        flash('El token no es valido o ha expirado', 'warning')
        return redirect(url_for('forgotpass'))
    reset_form = forms.ResetPasswordForm(request.form)
    if request.method == 'POST' and reset_form.validate():
        password = reset_form.password.data
        user.set_password(password, commit=True)
        database.session.commit()
        success_message = 'Tu contraseña se ha actualizado!'
        flash(success_message)
        return redirect(url_for('login'))
    return render_template('registro/reset_password.html', form = reset_form, token = token)

@app.route('/inicio/<username>', methods = ['POST', 'GET'])
def inicio(username):
    user = database.session.query(empresa).filter_by(empresa = username).first()
    #Minas
    contarMin0 = database.session.query(RegistrosSyP).filter_by(user_type = "Profesional", career ="Ingeniería de Minas").count()
    contarMin1 = database.session.query(RegistrosSyP).filter_by(user_type = "Egresado", career ="Ingeniería de Minas").count()
    contarMin2 = database.session.query(RegistrosSyP).filter_by(user_type = "Estudiante", career ="Ingeniería de Minas").count()
    contarMin = (contarMin0, contarMin1, contarMin2)
    #Geologia
    contarGeo0 = database.session.query(RegistrosSyP).filter_by(user_type = "Profesional", career ="Ingeniería en Geología").count()
    contarGeo1 = database.session.query(RegistrosSyP).filter_by(user_type = "Egresado", career ="Ingeniería en Geología").count() 
    contarGeo2 = database.session.query(RegistrosSyP).filter_by(user_type= "Estudiante", career ="Ingeniería en Geología").count()
    contarGeo = (contarGeo0, contarGeo1, contarGeo2)
    #Petroleos
    contarPetro0 = database.session.query(RegistrosSyP).filter_by(user_type = "Profesional", career ="Ingeniería en Petróleos").count()
    contarPetro1 = database.session.query(RegistrosSyP).filter_by(user_type = "Egresado", career ="Ingeniería en Petróleos").count()
    contarPetro2 = database.session.query(RegistrosSyP).filter_by(user_type = "Estudiante", career ="Ingeniería en Petróleos").count()
    contarPetro = (contarPetro0, contarPetro1, contarPetro2)
    #Ambeintal
    contarAmb0 = database.session.query(RegistrosSyP).filter_by(user_type = "Profesional", career = "Ingeniería Ambiental").count()
    contarAmb1 = database.session.query(RegistrosSyP).filter_by(user_type = "Egresado", career = "Ingeniería Ambiental").count()
    contarAmb2 = database.session.query(RegistrosSyP).filter_by(user_type = "Estudiante", career = "Ingeniería Ambiental").count()
    contarAmb = (contarAmb0, contarAmb1, contarAmb2)
    return render_template('company/home.html', contarMin = contarMin, contarGeo = contarGeo, contarPetro = contarPetro, contarAmb = contarAmb , user = user)     

# @app.context_processor
# def contar_user():
#     if not current_user.is_authenticated:
#         return {'num_articulos': 0}
#     if request.cookies.get(str(current_user.id)) is None:
#         return {'num_articulos': 0}
#     else:
#         datos = json.loads(request.cookies.get(str(current_user.id)))
#         return {'num_articulos': len(datos)}

@app.route('/logout')
def logout():
    if 'username' in session:
        session.pop('username')
    return redirect(url_for('home'))

""" FORMULARIOS DE PERFIL """
""" ------------------------------------------------------ """
@app.route("/profile/<username>", methods = ['POST', 'GET'])
def perfil(username):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    
    user_id = user.id
    educations = database.session.query(Education).filter_by(user_id = user_id).all()
    courses = database.session.query(Course).filter_by(user_id = user_id).all()
    publications = database.session.query(Publication).filter_by(user_id = user_id).all()
    volunteerings = database.session.query(Volunteering).filter_by(user_id = user_id).all()
    experiences = database.session.query(Experience).filter_by(user_id = user_id).all()
    languages = database.session.query(Language).filter_by(user_id = user_id).all()
    contact_form = forms.ContactForm(request.form)
    education_form = forms.EducationForm(request.form)
    course_form = forms.CourseForm(request.form)
    publication_form = forms.PublicationForm(request.form)
    volunteering_form = forms.VolunteeringForm(request.form)
    experience_form = forms.ExperienceForm(request.form)
    language_form = forms.LanguageForm(request.form)
    records = database.session.query(RegistrosSyP).filter_by(username = username).all()
    
    for record in records:
        recordObject = {
            'id': record.id,
            'username': record.username,
            'firstname': record.firstname,
            'lastname': record.lastname,
            'career': record.career,
        }

    if request.method == 'POST' and contact_form.validate():
        id = recordObject['id']
        user.age = contact_form.age.data
        user.user_type = contact_form.user_type.data
        user.contact = contact_form.contact.data
        user.mail_sec = contact_form.mail_sec.data
        user.about_me = contact_form.about_me.data
        database.session.commit()
        flash('Información de contacto agregada!','success')

        return redirect(url_for('perfil',username = username))
    
    elif request.method == 'GET':
        contact_form.age.data = user.age  
        contact_form.user_type.data = user.user_type
        contact_form.contact.data = user.contact
        contact_form.mail_sec.data = user.mail_sec
        contact_form.about_me.data = user.about_me
        database.session.commit()
        
    if request.method == 'POST' and education_form.validate():
        user_id = recordObject['id']
        education = Education(user_id = user_id, level_education = education_form.level_education.data, name_institution = education_form.name_institution.data, start_date = education_form.start_date.data, end_date = education_form.end_date.data, degree = education_form.degree.data,)
        database.session.add(education)
        database.session.commit()
        flash('Nivel de Instrucción creado exitosamente!', 'success')

        return redirect(url_for('perfil', username = username))
    
    if request.method == 'POST' and course_form.validate():
        user_id = recordObject['id']
        course = Course(user_id = user_id, description = course_form.description.data, area = course_form.area.data, start_date = course_form.start_date.data, end_date = course_form.end_date.data, time = course_form.time.data,)
        database.session.add(course)
        database.session.commit()
        flash('Curso/Capacticación añadido exitosamente!', 'success')

        return redirect(url_for('perfil', username = username))
    
    if request.method == 'POST' and publication_form.validate():
        user_id = recordObject['id']
        publication = Publication(user_id = user_id, title = publication_form.title.data, pub_date = publication_form.pub_date.data, link = publication_form.link.data, description = publication_form.description.data,)
        database.session.add(publication)
        database.session.commit()
        flash('Investigación/Publicación añadido exitosamente!', 'success')

        return redirect(url_for('perfil', username = username))
    
    if request.method == 'POST' and volunteering_form.validate():
        user_id = recordObject['id']
        volunteering = Volunteering(user_id = user_id, organization = volunteering_form.organization.data, possition = volunteering_form.possition.data, start_date =  volunteering_form.start_date.data, end_date = volunteering_form.end_date.data, activities = volunteering_form.activities.data,)
        database.session.add(volunteering)
        database.session.commit()
        flash('Voluntariado añadido exitosamente!', 'success')

        return redirect(url_for('perfil', username = username))
    
    if request.method == 'POST' and experience_form.validate():
        user_id = recordObject['id']
        experience = Experience(user_id = user_id, company = experience_form.company.data, area_e = experience_form.area_e.data, possition = experience_form.possition.data, start_date_e = experience_form.start_date_e.data, end_date_e = experience_form.end_date_e.data, time_e = experience_form.time_e.data)
        database.session.add(experience)
        database.session.commit()
        flash('Experiencia añadida exitosamente!', 'success')
        
        return redirect(url_for('perfil', username = username))
    
    if request.method == 'POST' and language_form.validate():
        user_id = recordObject['id']
        language = Language(user_id = user_id, language = language_form.language.data, level = language_form.level.data, study_center = language_form.study_center.data)
        database.session.add(language)
        database.session.commit()
        flash('Experiencia en idiomas añadida exitosamente!', 'success')
        
        return redirect(url_for('perfil', username = username))


    if user.photo == "u":
        namefile = "u.jpg"
    elif user.photo == username:
        namefile = username + ".jpg"

    if request.method =="POST":
        if 'archivo' not in request.files:
            return "El formulario no tiene la parte que corresponde al archivo"
        f = request.files['archivo']
        if f.filename == "":
            return  "No se ha seleccionado ningun archivo, intente de nuevo"
        filename = secure_filename(f.filename)
        namefile = username + ".jpg"
        user.photo = username
        database.session.commit()
        f.save(os.path.join(app.config['UPLOAD_FOLDER'], namefile))
        return redirect(url_for('perfil', username = username))   
    
    return render_template ('profile/profile.html', formcon = contact_form,educations=educations,formedu=education_form,formcou=course_form,formpub=publication_form,formvol=volunteering_form,formjob=experience_form,formlan=language_form, courses=courses, publications=publications, volunteerings=volunteerings, experiences=experiences, languages=languages,user=user, image_name = namefile, username = username, records=records)

@app.route("/perfil/<user_car>/<user_fil>", methods = ['POST', 'GET'])
def perfil_fil(user_car,user_fil):   
    user = database.session.query(RegistrosSyP).filter_by(username = user_fil).first()
    user_id = user.id
    educations = database.session.query(Education).filter_by(user_id = user_id).all()
    courses = database.session.query(Course).filter_by(user_id = user_id).all()
    publications = database.session.query(Publication).filter_by(user_id = user_id).all()
    volunteerings = database.session.query(Volunteering).filter_by(user_id = user_id).all()
    experiences = database.session.query(Experience).filter_by(user_id = user_id).all()
    languages = database.session.query(Language).filter_by(user_id = user_id).all()
    records = database.session.query(RegistrosSyP).filter_by(username = user_fil).all()
    if user_car == "Ingeniería de Minas":
        car = "Minas"
    elif user_car == "Ingeniería Ambiental":
        car = "Ambiental"
    elif user_car == "Ingeniería en Geología":
        car = "Geologia"
    elif user_car == "Ingeniería en Petróleos":
        car = "Petroleos"
    return render_template ('ing_filtro/profile_filtro.html',car = car, user = user, educations=educations, courses=courses, publications=publications, volunteerings=volunteerings, experiences=experiences, languages=languages, records=records)

@app.route("/perfil_rec", methods = ['POST', 'GET'])
def perfil_rec():
    username = session['username']      
    return redirect(url_for('perfil', username = username))

@app.route("/edit_education/attribute_<int:education_id>", methods = ['POST', 'GET'])
def edit_education(education_id):
    education = Education.query.get_or_404(education_id)
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    ueducation = Education.query.get_or_404(education_id)
    update_form = forms.UEducationForm(request.form)
    
    if education is not None and 'username' in session:
        pass
        if request.method == 'POST' and update_form.validate():
            ueducation.level_education = update_form.level_education.data
            ueducation.name_institution = update_form.name_institution.data
            ueducation.start_date = update_form.start_date.data
            ueducation.end_date = update_form.end_date.data
            ueducation.degree = update_form.degree.data
            database.session.commit()
            flash('La información de instrucción se actualizó exitosamente!', 'success')

            return redirect(url_for('edit_education', education_id = ueducation.id, form=update_form))
        
        elif request.method == 'GET':
            update_form.level_education.data = ueducation.level_education
            update_form.name_institution.data = ueducation.name_institution
            update_form.start_date.data = ueducation.start_date
            update_form.end_date.data = ueducation.end_date
            update_form.degree.data = ueducation.degree
            
        return render_template('profile/update_education.html', title='Update Education', legend='Update Education', form=update_form, user=user, education=education)

    else: 
        error_message1 = 'No se ha encontrado información de educación'
        flash(error_message1)
    
    return render_template('profile/update_education.html', education=education, user=user, form=update_form)

@app.route("/edit_course/attribute_<int:course_id>", methods = ['POST', 'GET'])
def edit_course(course_id):
    course = Course.query.get_or_404(course_id)
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    ucourse = Course.query.get_or_404(course_id)
    update_form = forms.UCourseForm(request.form)
    
    if course is not None and 'username' in session:
        pass
        if request.method == 'POST' and update_form.validate():
            ucourse.description = update_form.description.data
            ucourse.area = update_form.area.data
            ucourse.start_date = update_form.start_date.data
            ucourse.end_date = update_form.end_date.data
            ucourse.time = update_form.time.data
            database.session.commit()
            flash('El curso/capacitación se actualizó exitosamente!', 'success')

            return redirect(url_for('edit_course', course_id = ucourse.id, form=update_form))

        elif request.method == 'GET':
            update_form.description.data = ucourse.description
            update_form.area.data = ucourse.area
            update_form.start_date.data = ucourse.start_date
            update_form.end_date.data = ucourse.end_date
            update_form.time.data = ucourse.time

        return render_template('profile/update_course.html', title='Update course', legend='Update course', form=update_form, user=user, course=course)

    else: 
        error_message1 = 'No se ha encontrado información de curso/capacitación'
        flash(error_message1)
    
    return render_template('profile/update_course.html', course=course, user=user, form=update_form)

@app.route("/edit_publication/attribute_<int:publication_id>", methods = ['POST', 'GET'])
def edit_publication(publication_id):
    publication = Publication.query.get_or_404(publication_id)
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    upublication = Publication.query.get_or_404(publication_id)
    update_form = forms.UPublicationForm(request.form)
    
    if publication is not None and 'username' in session:
        pass
        if request.method == 'POST' and update_form.validate():
            upublication.title = update_form.title.data
            upublication.pub_date = update_form.pub_date.data
            upublication.link = update_form.link.data
            upublication.description = update_form.description.data
            database.session.commit()
            flash('La investigación/publicación se actualizó exitosamente!', 'success')

            return redirect(url_for('edit_publication', publication_id = upublication.id, form=update_form))

        elif request.method == 'GET':
            update_form.title.data = upublication.title
            update_form.pub_date.data = upublication.pub_date
            update_form.link.data = upublication.link
            update_form.description.data = upublication.description

        return render_template('profile/update_publication.html', title='Update publication', legend='Update publication', form=update_form, user=user, publication=publication)
        
    else: 
        error_message1 = 'No se ha encontrado información de publicación/investigaación'
        flash(error_message1)
    
    return render_template('profile/update_publication.html', publication=publication, user=user, form=update_form)

@app.route("/edit_volunteering/attribute_<int:volunteering_id>", methods = ['POST', 'GET'])
def edit_volunteering(volunteering_id):
    volunteering = Volunteering.query.get_or_404(volunteering_id)
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    uvolunteering = Volunteering.query.get_or_404(volunteering_id)
    update_form = forms.UVolunteeringForm(request.form)

    if volunteering is not None and 'username' in session:
        pass
        if request.method == 'POST' and update_form.validate():
            uvolunteering.organization = update_form.organization.data
            uvolunteering.possition = update_form.possition.data
            uvolunteering.start_date = update_form.start_date.data
            uvolunteering.end_date = update_form.end_date.data
            uvolunteering.activities = update_form.activities.data
            database.session.commit()
            flash('La experiencia de voluntariado se actualizó exitosamente!', 'success')
            return redirect(url_for('edit_volunteering', volunteering_id = uvolunteering.id, form=update_form))
        elif request.method == 'GET':
            update_form.organization.data = uvolunteering.organization
            update_form.possition.data = uvolunteering.possition
            update_form.start_date.data = uvolunteering.start_date
            update_form.end_date.data = uvolunteering.end_date
            update_form.activities.data = uvolunteering.activities
        return render_template('profile/update_volunteering.html', title='Update volunteering', legend='Update volunteering', form=update_form, user=user, volunteering = volunteering)
    else: 
        error_message1 = 'No se ha encontrado información de voluntariado'
        flash(error_message1)
    
    return render_template('profile/update_volunteering.html', volunteering=volunteering, user=user, form=update_form)

@app.route("/edit_experience/attribute_<int:experience_id>", methods = ['POST', 'GET'])
def edit_experience(experience_id):
    experience = Experience.query.get_or_404(experience_id)
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    uexperience = Experience.query.get_or_404(experience_id)
    update_form = forms.UExperienceForm(request.form)
    
    if experience is not None and 'username' in session:
        pass
        if request.method == 'POST' and update_form.validate():
            uexperience.company = update_form.company.data
            uexperience.area_e = update_form.area_e.data
            uexperience.possition = update_form.possition.data
            uexperience.start_date_e = update_form.start_date_e.data 
            uexperience.end_date_e = update_form.end_date_e.data
            uexperience.time_e = update_form.time_e.data
            database.session.commit()
            flash('La experiencia laboral se actualizó exitosamente!', 'success')
            return redirect(url_for('edit_experience', experience_id = uexperience.id, form=update_form))
        elif request.method == 'GET':
            update_form.company.data = uexperience.company
            update_form.area_e.data = uexperience.area_e
            update_form.possition.data = uexperience.possition
            update_form.start_date_e.data = uexperience.start_date_e
            update_form.end_date_e.data = uexperience.end_date_e
            update_form.time_e.data = uexperience.time_e
        return render_template('profile/update_experience.html', title='Update experience', legend='Update experience', form=update_form, user=user, experience=experience)
    else: 
        error_message1 = 'No se ha encontrado información de voluntariado'
        flash(error_message1)
    
    return render_template('profile/update_experience.html', experience=experience, user=user, form=update_form) 

@app.route("/edit_language/attribute_<int:language_id>", methods = ['POST', 'GET'])
def edit_language(language_id):
    language = Language.query.get_or_404(language_id)
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    ulanguage = Language.query.get_or_404(language_id)
    update_form = forms.ULanguageForm(request.form)
    
    if language is not None and 'username' in session:
        pass
        if request.method == 'POST' and update_form.validate():
            ulanguage.language = update_form.language.data
            ulanguage.level = update_form.level.data
            ulanguage.study_center = update_form.study_center.data
            database.session.commit()
            flash('Nivel de idiomas se actualizó exitosamente!', 'success')
            return redirect(url_for('edit_language', language_id = ulanguage.id, form=update_form))
        elif request.method == 'GET':
            update_form.language.data = ulanguage.language
            update_form.level.data = ulanguage.level
            update_form.study_center.data = ulanguage.study_center
        return render_template('profile/update_language.html', title='Update language', legend='Update language', form=update_form, user=user, language=language)
    else: 
        error_message1 = 'No se ha encontrado información de voluntariado'
        flash(error_message1)
    
    return render_template('profile/update_language.html', language=language, user=user, form=update_form) 
    
@app.route("/delete_education_<int:education_id>", methods=['POST'])
def delete_education(education_id):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    education = Education.query.get_or_404(education_id)
    database.session.delete(education)
    database.session.commit()
    flash('Se ha eliminado la información!', 'success')
    return redirect(url_for('perfil', username = username))

@app.route("/delete_course_<int:course_id>", methods=['POST'])
def delete_course(course_id):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    course = Course.query.get_or_404(course_id)
    database.session.delete(course)
    database.session.commit()
    flash('Se ha eliminado la información!', 'success')
    return redirect(url_for('perfil', username = username))

@app.route("/delete_publication_<int:publication_id>", methods=['POST'])
def delete_publication(publication_id):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    publication = Publication.query.get_or_404(publication_id)
    database.session.delete(publication)
    database.session.commit()
    flash('Se ha eliminado la información!', 'success')
    return redirect(url_for('perfil', username = username))

@app.route("/delete_volunteering_<int:volunteering_id>", methods=['POST'])
def delete_volunteering(volunteering_id):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    volunteering = Volunteering.query.get_or_404(volunteering_id)
    database.session.delete(volunteering)
    database.session.commit()
    flash('Se ha eliminado la información!', 'success')
    return redirect(url_for('perfil', username = username))

@app.route("/delete_experience_<int:experience_id>", methods=['POST'])
def delete_experience(experience_id):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    experience = Experience.query.get_or_404(experience_id)
    database.session.delete(experience)
    database.session.commit()
    flash('Se ha eliminado la información!', 'success')
    return redirect(url_for('perfil', username = username))

@app.route("/delete_language_<int:language_id>", methods=['POST'])
def delete_language(language_id):
    username = session['username']
    user = database.session.query(RegistrosSyP).filter_by(username = username).first()
    language = Language.query.get_or_404(language_id)
    database.session.delete(language)
    database.session.commit()
    flash('Se ha eliminado la información!', 'success')
    return redirect(url_for('perfil', username = username))

#Page Carreras
@app.route('/carrera/Minas', methods = ['POST', 'GET'])
def Minas():
    username = session['username']
    user = database.session.query(empresa).filter_by(empresa = username).first()
    car = ('CARRERA DE MINAS','Minas','carrera_min')
    carreras = database.session.query(RegistrosSyP).filter_by(career = "Ingeniería de Minas").all()
    return render_template('ing_filtro/carrera.html', carreras = carreras, user = user, car = car)

@app.route('/carrera/Ambiental', methods = ['POST', 'GET'])
def Ambiental():
    username = session['username']
    user = database.session.query(empresa).filter_by(empresa = username).first()
    car = ('CARRERA DE AMBIENTAL','Ambiental','carrera_amb')
    carreras = database.session.query(RegistrosSyP).filter_by(career = "Ingeniería Ambiental").all()
    return render_template('ing_filtro/carrera.html', carreras = carreras, car =car, user = user)

@app.route('/carrera/Geologia', methods = ['POST', 'GET'])
def Geologia():
    username = session['username']
    user = database.session.query(empresa).filter_by(empresa = username).first()
    car = ('CARRERA DE GEOLOGÍA','Geología')
    carreras = database.session.query(RegistrosSyP).filter_by(career = "Ingeniería en Geología").all()
    return render_template('ing_filtro/carrera.html', carreras = carreras, car =car, user = user)

@app.route('/carrera/Petróleos', methods = ['POST', 'GET'])
def Petroleos():
    username = session['username']
    user = database.session.query(empresa).filter_by(empresa = username).first()
    car = ('CARRERA DE PETRÓLEOS','Petróleos')
    carreras = database.session.query(RegistrosSyP).filter_by(career = "Ingeniería en Petróleos").all()
    return render_template('ing_filtro/carrera.html', carreras = carreras, car =car, user = user)


@app.route('/Filtro', methods = ['POST', 'GET'])
def seleccion():
    username = session['username']
    user = database.session.query(empresa).filter_by(empresa = username).first()
    filt_form = forms.FiltroForm(request.form)
    
    if request.method == 'POST':
        carrera_f = filt_form.carrera.data
        tipo_f = filt_form.tipo_u.data
        nivel = filt_form.nivel_i.data
        area = filt_form.area_c.data
        areat = filt_form.area_t.data
        idioma = filt_form.idioma_f.data
        if carrera_f == "Todas" and tipo_f == "Todas" and nivel == "Todas" and area == "Todas" and areat == "Todas" and idioma == "Todas":
            us = RegistrosSyP.query.all()
        elif carrera_f == "Todas":
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Education, Education.user_id == RegistrosSyP.id)\
                .join(Course, Course.user_id == RegistrosSyP.id)\
                .join(Experience, Experience.user_id == RegistrosSyP.id)\
                .join(Language, Language.user_id == RegistrosSyP.id).filter(RegistrosSyP.user_type == tipo_f, Education.level_education == nivel, Course.area == area, Experience.area_e == areat, Language.language == idioma).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq                
        elif tipo_f == "Todas":
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Education, Education.user_id == RegistrosSyP.id)\
                .join(Course, Course.user_id == RegistrosSyP.id)\
                .join(Experience, Experience.user_id == RegistrosSyP.id)\
                .join(Language, Language.user_id == RegistrosSyP.id).filter(RegistrosSyP.career == carrera_f, Education.level_education == nivel, Course.area == area, Experience.area_e == areat, Language.language == idioma).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq                
        elif nivel == "Todas":
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Course, Course.user_id == RegistrosSyP.id)\
                .join(Experience, Experience.user_id == RegistrosSyP.id)\
                .join(Language, Language.user_id == RegistrosSyP.id).filter(RegistrosSyP.career == carrera_f, RegistrosSyP.user_type == tipo_f, Course.area == area, Experience.area_e == areat, Language.language == idioma).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq            
        elif area == "Todas":
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Education, Education.user_id == RegistrosSyP.id)\
                .join(Experience, Experience.user_id == RegistrosSyP.id)\
                .join(Language, Language.user_id == RegistrosSyP.id).filter(RegistrosSyP.career == carrera_f, RegistrosSyP.user_type == tipo_f, Education.level_education == nivel, Experience.area_e == areat, Language.language == idioma).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq                
        elif areat == "Todas":
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Education, Education.user_id == RegistrosSyP.id)\
                .join(Course, Course.user_id == RegistrosSyP.id)\
                .join(Language, Language.user_id == RegistrosSyP.id).filter(RegistrosSyP.career == carrera_f, RegistrosSyP.user_type == tipo_f, Education.level_education == nivel, Course.area == area, Language.language == idioma).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq                
        elif idioma == "Todas":
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Education, Education.user_id == RegistrosSyP.id)\
                .join(Course, Course.user_id == RegistrosSyP.id)\
                .join(Experience, Experience.user_id == RegistrosSyP.id).filter(RegistrosSyP.career == carrera_f, RegistrosSyP.user_type == tipo_f, Education.level_education == nivel, Course.area == area, Experience.area_e == areat).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq    
        else:
            usa = database.session.query(RegistrosSyP, Education, Course, Experience, Language)\
                .join(Education, Education.user_id == RegistrosSyP.id)\
                .join(Course, Course.user_id == RegistrosSyP.id)\
                .join(Experience, Experience.user_id == RegistrosSyP.id)\
                .join(Language, Language.user_id == RegistrosSyP.id).filter(RegistrosSyP.career == carrera_f, RegistrosSyP.user_type == tipo_f, Education.level_education == nivel, Course.area == area, Experience.area_e == areat, Language.language == idioma).all()
            aa=[7]
            qq=[]
            bb=0
            for n in usa:
                cc = usa[bb]
                bb += 1
                ww = 0
                for x in aa:
                    q=cc[ww]
                qq.append(q)
            us = qq
        return render_template('ing_filtro/filtro.html', user = user, form = filt_form, us =us)
          
    return render_template('ing_filtro/filtro.html', user = user, form = filt_form)




if __name__ == '__main__':
    csrf.init_app(app)
    login_manager.init_app(app)
    with app.app_context():
        database.create_all()
    app.run(debug=True)

database.init_app(app)
mail.init_app(app)