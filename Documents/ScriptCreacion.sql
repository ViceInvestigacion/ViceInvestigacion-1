--Creacion database--
CREATE DATABASE DB_VicerrectoradoInv; 
go 
use DB_VicerrectoradoInv
go
--Creacion menuBE--
--descripcion: Aqui se registraran los menus que van a ser utilizados 
--
CREATE TABLE menuBE (
  id_Menu INT IDENTITY(1,1) NOT NULL,
  descripcion_Menu varchar(45) NOT NULL,
  direccion_Menu varchar(45) NOT NULL,
  estado_Menu INT NOT NULL,
  padre_Menu INT DEFAULT NULL,
  PRIMARY KEY (id_Menu),
  CONSTRAINT fk_MenuBE_MenuBE1 FOREIGN KEY (padre_Menu) REFERENCES menuBE (id_menu)
) ;
--Creacion rolBE--
--descripcion: Aqui se registraran los roles de los usuarios
--
CREATE TABLE rolBE (
  id_Rol INT IDENTITY(1,1) NOT NULL,
  descripcion_Rol varchar(100) NOT NULL,
  estado_Rol INT NOT NULL,
  PRIMARY KEY (id_Rol)
) ;
--Creacion accesoBE--
--descripcion: Tabla intermedia entre rol y menu para definir los accesos de cada rol
--
CREATE TABLE accesoBE (
  id_acc INT IDENTITY(1,1) NOT NULL,
  descripcion_acc varchar(100) NOT NULL,
  estado_acc INT NOT NULL,
  id_Menu INT NOT NULL,
  id_Rol INT NOT NULL,
  PRIMARY KEY (id_acc),
  CONSTRAINT fk_AccesoBE_MenuBE1 FOREIGN KEY (id_Menu) REFERENCES menuBE (id_menu),
  CONSTRAINT fk_AccesoBE_RolBE1 FOREIGN KEY (id_Rol) REFERENCES rolBE (id_rol)
) ;
--Creacion tipoAsistenteBE--
--descripcion: Aqui se registraran los tipos de asistentes a los eventos
--General, Alumno
CREATE TABLE tipoAsistenteBE (
  id_TipoAs INT IDENTITY(1,1) NOT NULL,
  descripcion_TipoAs varchar(50) NOT NULL,
  estado_TipoAs INT NOT NULL,
  PRIMARY KEY (id_TipoAs)
) ;
--Creacion facultadBE--
--descripcion: Todas las facultad de la UNJFSC
--
CREATE TABLE facultadBE (
  id_Facu INT IDENTITY(1,1) NOT NULL,
  nombre_Facu varchar(100) NOT NULL,
  PRIMARY KEY (id_Facu)
) ;
--Creacion escuelaBE--
--descripcion: Todas las escuelas de la UNJFSC
--
CREATE TABLE escuelaBE (
  id_Escuela INT IDENTITY(1,1) NOT NULL,
  nombre_Escuela varchar(100) NOT NULL,
  facultadId_Escuela INT NOT NULL,
  PRIMARY KEY (id_Escuela),
  CONSTRAINT fk_EscuelaBE_FacultadBE1 FOREIGN KEY (facultadId_Escuela) REFERENCES facultadBE (id_Facu)
) ;
--Creacion personalBE--
--descripcion: nombre del pesonal que estará a cargo de la cuenta de usuario
--
CREATE TABLE personalBE (
  id_Personal INT IDENTITY(1,1) NOT NULL,
  dni_Personal varchar(8) NOT NULL,
  nombres_Personal varchar(45) NOT NULL,
  fecNac_Personal date NOT NULL,
  apellidos_Personal varchar(45) NOT NULL,
  estado_Personal INT NOT NULL,
  fecRegistro_Personal date NOT NULL,
  usuReg_Personal INT DEFAULT NULL,
  escuela_Personal INT DEFAULT NULL,
  PRIMARY KEY (id_Personal),
  CONSTRAINT fk_PersonalBE_EscuelaBE1 FOREIGN KEY (escuela_Personal) REFERENCES escuelaBE (id_escuela)
) ;
--Creacion usuarioBE--
--descripcion: usuarios para acceder al sistema
--
CREATE TABLE usuarioBE (
  id_Usu INT IDENTITY(1,1) NOT NULL,
  nombre_Usu varchar(45) NOT NULL,
  clave_Usu varchar(45) NOT NULL,
  estado_Usu INT NOT NULL,
  fecReg_Usu date NOT NULL,
  usuReg_Usu INT DEFAULT NULL,
  personal_Usu INT NOT NULL,
  perfil_Usu INT NOT NULL,
  RolBE_id_rol INT NOT NULL,
  PRIMARY KEY (id_Usu),
  CONSTRAINT fk_UsuarioBE_PersonalBE1 FOREIGN KEY (personal_Usu) REFERENCES personalBE (id_personal),
  CONSTRAINT fk_UsuarioBE_RolBE1 FOREIGN KEY (RolBE_id_rol) REFERENCES rolBE (id_rol)
) ;
--Creacion asistenteBE--
--descripcion: asistentes a los eventos
--
CREATE TABLE asistenteBE (
  id_Asis INT IDENTITY(1,1) NOT NULL,
  dni_Asis varchar(8) NOT NULL,
  nombres_Asis varchar(45) NOT NULL,
  apellidos_Asis varchar(45) NOT NULL,
  especialidad_Asis varchar(45) NOT NULL,
  universidadProc_Asis INT NOT NULL,
  fecNac_Asis date NOT NULL,
  correo_Asis varchar(45) NOT NULL,
  telefono_Asis varchar(10) NOT NULL,
  fecReg_Asis date NOT NULL,
  usuReg_Asis INT NOT NULL,
  tipoAsis_Asis INT NOT NULL,
  PRIMARY KEY (id_Asis),
  CONSTRAINT fk_AsistenteBE_TipoAsistenteBE1 FOREIGN KEY (tipoAsis_Asis) REFERENCES tipoasistenteBE (id_tipoas),
  CONSTRAINT fk_AsistenteBE_UsuarioBE1 FOREIGN KEY (usuReg_Asis) REFERENCES usuarioBE (id_usu)
) ;
--Creacion proyectoBE--
--descripcion: proyectos de los docentes y alumnos de la UNJFSC
--
CREATE TABLE proyectoBE (
  id_Proyecto INT IDENTITY(1,1) NOT NULL,
  titulo_Proyecto varchar(200) NOT NULL,
  descripcion_Proyecto varchar(200) NOT NULL,
  presupuesto_Proyecto decimal(9,2) NOT NULL,
  enlace_Proyecto varchar(60) NOT NULL,
  usuReg INT DEFAULT NULL,
  escuelaId_Proyecto INT NOT NULL,
  fecReg date NOT NULL,
  PRIMARY KEY (id_Proyecto),
  CONSTRAINT fk_ProyectoBE_UsuarioBE1 FOREIGN KEY (usuReg) REFERENCES usuarioBE (id_usu),
  CONSTRAINT fk_ProyectoBE_EscuelaBE1 FOREIGN KEY (escuelaId_Proyecto) REFERENCES escuelaBE (id_Escuela)
) ;
--Creacion comunidadAutoBE--
--descripcion: comunidades autonomas que apoyan los proyectos
--
CREATE TABLE comunidadAutoBE (
  id_CA INT IDENTITY(1,1) NOT NULL,
  nombre_CA INT NOT NULL,
  usuReg INT NOT NULL,
  fecReg date NOT NULL,
  PRIMARY KEY (id_CA)
) ;
--Creacion comunidadProyBE--
--descripcion: tabla intermedia entre Proyectos y Comunidades Autonomas
--
CREATE TABLE comunidadProyBE (
  id_CP INT IDENTITY(1,1) NOT NULL,
  proyecto_CP INT NOT NULL,
  comunidad_CP INT NOT NULL,
  PRIMARY KEY (id_CP),
  CONSTRAINT fk_ComunidadProyBE_ComunidadAutoBE1 FOREIGN KEY (comunidad_CP) REFERENCES comunidadautoBE (id_ca),
  CONSTRAINT fk_ComunidadProyBE_ProyectoBE1 FOREIGN KEY (proyecto_CP) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion convocatoriaBE--
--descripcion: Convocatorias a concursos 
--
CREATE TABLE convocatoriaBE (
  id_Conv INT IDENTITY(1,1) NOT NULL,
  descripcion_Conv varchar(45) NOT NULL,
  imagen_Conv varbinary(max) NOT NULL,
  fecha_Conv date NOT NULL,
  estado_Conv INT NOT NULL,
  usuReg_Conv INT NOT NULL,
  fecReg_Conv date NOT NULL,
  PRIMARY KEY (id_Conv),
  CONSTRAINT fk_ConvocatoriaBE_UsuarioBE1 FOREIGN KEY (usuReg_Conv) REFERENCES usuarioBE (id_usu)
) ;
--Creacion entidadColaBE--
--descripcion: entidades Colaboradoras de los proyectos
--
CREATE TABLE entidadColaBE (
  id_EntidadCola INT IDENTITY(1,1) NOT NULL,
  nombre varchar(45) NOT NULL,
  descripcion varchar(45) NOT NULL,
  usuReg INT NOT NULL,
  fecReg date NOT NULL,
  PRIMARY KEY (id_EntidadCola)
) ;
--Creacion entidadCProyBE--
--descripcion: tabla intermedia entre Proyectos y Entidades Colaboradoras 
--
CREATE TABLE entidadCProyBE (
  id_ECP INT IDENTITY(1,1) NOT NULL,
  proyecto_ECP INT NOT NULL,
  entidadC_ECP INT NOT NULL,
  PRIMARY KEY (id_ECP),
  CONSTRAINT fk_EntidadCProyBE_EntidadColaBE1 FOREIGN KEY (entidadC_ECP) REFERENCES entidadcolaBE (id_entidadcola),
  CONSTRAINT fk_EntidadCProyBE_ProyectoBE1 FOREIGN KEY (proyecto_ECP) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion tesisBE--
--descripcion: tesis de todas las facultades y escuelas 
--
CREATE TABLE tesisBE (
  id_Tesis INT IDENTITY(1,1) NOT NULL,
  titulo_Tesis varchar(45) NOT NULL,
  escuela_Tesis INT NOT NULL,
  fecha_Tesis date NOT NULL,
  escuelaId_Tesis INT NOT NULL,
  PRIMARY KEY (id_Tesis),
  CONSTRAINT fk_TesisBE_EscuelaBE1 FOREIGN KEY (escuelaId_Tesis) REFERENCES escuelaBE (id_Escuela)
) ;

--Creacion especialidadBE--
--descripcion: especialidades de los ponentes en los eventos
--
CREATE TABLE especialidadBE (
  id_Espe INT IDENTITY(1,1) NOT NULL,
  descripcion_Espe varchar(45) DEFAULT NULL,
  estado_Espe INT DEFAULT NULL,
  PRIMARY KEY (id_Espe)
) ;
--Creacion tipoEventoBE--
--descripcion: tipos de eventos  
-- ponencias, ferias
CREATE TABLE tipoEventoBE (
  id_TipoEv INT IDENTITY(1,1) NOT NULL,
  descripcion_TipoEv varchar(45) DEFAULT NULL,
  estado_TipoEv INT DEFAULT NULL,
  fecReg_TipoEv date DEFAULT NULL,
  usuReg_TipoEv INT DEFAULT NULL,
  PRIMARY KEY (id_TipoEv),
  CONSTRAINT fk_TipoEventoBE_UsuarioBE1 FOREIGN KEY (usuReg_TipoEv) REFERENCES usuarioBE (id_usu)
) ;
--Creacion eventoBE--
--descripcion: eventos a realizarse
--
CREATE TABLE eventoBE (
  id_Evento INT IDENTITY(1,1) NOT NULL,
  nombre_Evento varchar(45) NOT NULL,
  descripcion_Evento varchar(200) NOT NULL,
  tipo_Evento INT NOT NULL,
  duracion_Evento varchar(20) NOT NULL,
  fecInicio_Evento date NOT NULL,
  fecFin_Evento date NOT NULL,
  horaInicio_Evento varchar(20) NOT NULL,
  horaFin_Evento varchar(20) NOT NULL,
  cstGSnCertificado_Evento decimal(5,2) NOT NULL,
  cstGCnCertificado_Evento decimal(5,2) NOT NULL,
  cstFCnCertificado_Evento decimal(5,2) NOT NULL,
  detalle_Evento INT NOT NULL,
  imagen_Evento varbinary(max) NOT NULL,
  usuReg_Evento INT NOT NULL,
  fecReg_Evento date NOT NULL,
  PRIMARY KEY (id_Evento),
  CONSTRAINT fk_EventoBE_TipoEventoBE FOREIGN KEY (tipo_Evento) REFERENCES tipoeventoBE (id_tipoev),
  CONSTRAINT fk_EventoBE_UsuarioBE1 FOREIGN KEY (usuReg_Evento) REFERENCES usuarioBE (id_usu)
) ;
--Creacion eventoAsistenteBE--
--descripcion: tabla intermedia entre Evento y Asistentes
--
CREATE TABLE eventoAsistenteBE (
  id_EventoAsis INT IDENTITY(1,1) NOT NULL,
  evento_EventoAsis INT DEFAULT NULL,
  asistente_EventoAsis INT DEFAULT NULL,
  PRIMARY KEY (id_EventoAsis),
  CONSTRAINT fk_EventoAsitente_AsistenteBE1 FOREIGN KEY (asistente_EventoAsis) REFERENCES asistenteBE (id_asis),
  CONSTRAINT fk_EventoAsitente_EventoBE1 FOREIGN KEY (evento_EventoAsis) REFERENCES eventoBE (id_evento)
) ;
--Creacion universidadBE--
--descripcion: universidad de procedencia de los ponentes 
--
CREATE TABLE universidadBE (
  id_Uni INT IDENTITY(1,1) NOT NULL,
  nombre_Uni varchar(80) NOT NULL,
  PRIMARY KEY (id_Uni)
) ;
--Creacion ponenteBE--
--descripcion: ponentes de los eventos
--
CREATE TABLE ponenteBE (
  id_Ponente INT IDENTITY(1,1) NOT NULL,
  dni_Ponente varchar(8) NOT NULL,
  nombres_Ponente varchar(50) NOT NULL,
  apellidos_Ponente varchar(50) NOT NULL,
  especialidad_Ponente INT NOT NULL,
  univProc_Ponente INT NOT NULL,
  fecNac_Ponente date NOT NULL,
  correo_Ponente varchar(45) NOT NULL,
  telefono_Ponente varchar(45) NOT NULL,
  usuReg_Ponente INT NOT NULL,
  fecReg_Ponente date NOT NULL,
  PRIMARY KEY (id_Ponente),
  CONSTRAINT fk_PonenteBE_Especialidad1 FOREIGN KEY (especialidad_Ponente) REFERENCES especialidadBE (id_espe),
  CONSTRAINT fk_PonenteBE_Universidad1 FOREIGN KEY (univProc_Ponente) REFERENCES universidadBE (id_uni),
  CONSTRAINT fk_PonenteBE_UsuarioBE1 FOREIGN KEY (usuReg_Ponente) REFERENCES usuarioBE (id_usu)
) ;
--Creacion eventoDetalleBE--
--descripcion: tabla intermedia entre Evento y Ponentes
--
CREATE TABLE eventoDetalleBE (
  id_EventoDet INT IDENTITY(1,1) NOT NULL,
  descripcion_EventoDet varchar(45) NOT NULL,
  evento_EventoDet INT NOT NULL,
  ponente_EventoDet INT NOT NULL,
  estado_EventoDet INT NOT NULL,
  fecReg_EventoDet date NOT NULL,
  usuReg_EventoDet INT NOT NULL,
  PRIMARY KEY (id_EventoDet),
  CONSTRAINT fk_EventoDetalleBE_EventoBE1 FOREIGN KEY (evento_EventoDet) REFERENCES eventoBE (id_evento),
  CONSTRAINT fk_EventoDetalleBE_PonenteBE1 FOREIGN KEY (ponente_EventoDet) REFERENCES ponenteBE (id_ponente),
  CONSTRAINT fk_EventoDetalleBE_UsuarioBE1 FOREIGN KEY (usuReg_EventoDet) REFERENCES usuarioBE (id_usu)
) ;
--Creacion fechaEjeBE--
--descripcion: Fechas de ejecuciones de los proyectos
--
CREATE TABLE fechaEjeBE (
  id_FE INT IDENTITY(1,1) NOT NULL,
  actividad_FE varchar(150) NOT NULL,
  fecha date NOT NULL,
  PRIMARY KEY (id_FE)
) ;
--Creacion fechaProBE--
--descripcion: tabla intermedia entre Proyecto y sus fechas de ejecuciones
--
CREATE TABLE fechaProyBE (
  id_FP INT IDENTITY(1,1) NOT NULL,
  proyecto_FP INT NOT NULL,
  fechaEje_FP INT NOT NULL,
  PRIMARY KEY (id_FP),
  CONSTRAINT fk_FechaProyBE_FechaEjeBE1 FOREIGN KEY (fechaEje_FP) REFERENCES fechaejeBE (id_fe),
  CONSTRAINT fk_FechaProyBE_ProyectoBE1 FOREIGN KEY (proyecto_FP) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion nosotrosBE--
--descripcion: Aqui se registrara la descripcion del Vicerrectorado
--
CREATE TABLE nosotrosBE (
  id_Nos INT IDENTITY(1,1) NOT NULL,
  descripcion_Nos varchar(200) NOT NULL,
  vision_Nos varchar(200) NOT NULL,
  mision_Nos varchar(200) NOT NULL,
  organigrama_Nos varbinary(max) NOT NULL,
  directorio_Nos varbinary(max) NOT NULL,
  estado_Nos INT NOT NULL,
  usuMod_Nos INT NOT NULL,
  fecMod_Nos date NOT NULL,
  PRIMARY KEY (id_Nos),
  CONSTRAINT fk_NosotrosBE_UsuarioBE1 FOREIGN KEY (usuMod_Nos) REFERENCES usuarioBE (id_usu)
) ;
--Creacion noticiaBE--
--descripcion: Aqui se registraran las noticias
--
CREATE TABLE noticiaBE (
  id_Noticia INT IDENTITY(1,1) NOT NULL,
  descripcion_Noticia varchar(200) NOT NULL,
  fecha_Noticia date NOT NULL,
  estado_Noticia INT NOT NULL,
  imagen_Noticia varbinary(max) NOT NULL,
  usuReg_Noticia INT NOT NULL,
  fecReg_Noticia date NOT NULL,
  PRIMARY KEY (id_Noticia),
  CONSTRAINT fk_NoticiaBE_UsuarioBE1 FOREIGN KEY (usuReg_Noticia) REFERENCES usuarioBE (id_usu)
) ;
--Creacion objetivoBE--
--descripcion: objetivos de los proyectos 
--
CREATE TABLE objetivoBE (
  id_Objetivo INT IDENTITY(1,1) NOT NULL,
  descripcion varchar(200) NOT NULL,
  PRIMARY KEY (id_Objetivo)
) ;
--Creacion objetivoPryBE--
--descripcion: tabla intermedia entre un Proeycto y sus objetivos
--
CREATE TABLE objetivoPryBE (
  id_ObjetivoPry INT IDENTITY(1,1) NOT NULL,
  proyecto_ObjetivoPry INT NOT NULL,
  objetivo_ObjetivoPry INT NOT NULL,
  PRIMARY KEY (id_ObjetivoPry),
  CONSTRAINT fk_ObjetivoPryBE_ObjetivoBE1 FOREIGN KEY (objetivo_ObjetivoPry) REFERENCES objetivoBE (id_objetivo),
  CONSTRAINT fk_ObjetivoPryBE_ProyectoBE1 FOREIGN KEY (proyecto_ObjetivoPry) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion pagoBE--
--descripcion: pagos para asistir a los eventos
--
CREATE TABLE pagoBE (
  id_Pago INT IDENTITY(1,1) NOT NULL,
  imagen_Pago varbinary(max) NOT NULL,
  eventoAsis_Pago INT NOT NULL,
  estado_Pago INT NOT NULL,
  usuApr_Pago INT NOT NULL,
  fecha_Pago date NOT NULL,
  fechaApr_Pago date NOT NULL,
  PRIMARY KEY (id_Pago),
  CONSTRAINT fk_PagoBE_EventoAsitente1 FOREIGN KEY (eventoAsis_Pago) REFERENCES eventoAsistenteBE (id_eventoAsis),
  CONSTRAINT fk_PagoBE_UsuarioBE1 FOREIGN KEY (usuApr_Pago) REFERENCES usuarioBE (id_usu)
) ;
--Creacion profesionBE--
--descripcion: profesiones de los suscriptores al boletin 
--
CREATE TABLE profesionBE (
  id_Prof INT IDENTITY(1,1) NOT NULL,
  nombre_Prof varchar(80) NOT NULL,
  PRIMARY KEY (id_Prof)
) ;
--Creacion resolucionBE--
--descripcion: Aqui se registraran las Resoluciones del Vicerrectorado
--
CREATE TABLE resolucionBE (
  id_Resolucion INT IDENTITY(1,1) NOT NULL,
  descripcion_Resolucion varchar(200) NOT NULL,
  archivo_Resolucion varbinary(max) NOT NULL,
  usuReg INT NOT NULL,
  fecReg date NOT NULL,
  PRIMARY KEY (id_Resolucion),
  CONSTRAINT fk_Resolucion_UsuarioBE1 FOREIGN KEY (usuReg) REFERENCES usuarioBE (id_usu)
) ;
--Creacion resultadoBE--
--descripcion: Aqui se registraran los resultados de los concursos
--
CREATE TABLE resultadoBE (
  id_Resultado INT IDENTITY(1,1) NOT NULL,
  descripcion_Resultado varchar(150) NOT NULL,
  imagen_Resultado varbinary(max) NOT NULL,
  concurso_Resultado INT NOT NULL,
  estado_Resultado INT NOT NULL,
  usuReg_Resultado INT NOT NULL,
  fecReg_Resultado date NOT NULL,
  PRIMARY KEY (id_Resultado),
  CONSTRAINT fk_ResultadoBE_ConvocatoriaBE1 FOREIGN KEY (concurso_Resultado) REFERENCES convocatoriaBE (id_conv),
  CONSTRAINT fk_ResultadoBE_UsuarioBE1 FOREIGN KEY (usuReg_Resultado) REFERENCES usuarioBE (id_usu)
) ;
--Creacion suscriptorBE--
--descripcion: registro de los suscriptores al boletin informativo
--
CREATE TABLE suscriptorBE (
  id_Susc INT IDENTITY(1,1) NOT NULL,
  nombres_Susc varchar(45) NOT NULL,
  apellidos_Susc varchar(45) NOT NULL,
  correo_Susc varchar(45) NOT NULL,
  estado_Susc INT NOT NULL,
  entidad_Susc varchar(70) DEFAULT NULL,
  profesion_Susc INT DEFAULT NULL,
  PRIMARY KEY (id_Susc),
  CONSTRAINT fk_SuscriptorBE_ProfesionBE1 FOREIGN KEY (profesion_Susc) REFERENCES profesionBE (id_prof)
) ;






