--Insert Menu--
INSERT INTO  menuBE VALUES('Inicio','unjsfc/Inicio',1,NULL);

--Insert Rol
INSERT INTO  rolBE VALUES('ADMINISTRADOR',1);

--Insert Acceso--
INSERT INTO  accesoBE VALUES('ADMIN-INICIO',1,1,1);

--Insert Tipo Asistente
INSERT INTO  tipoAsistenteBE VALUES('GENERAL',1);

--Insert Facultad
INSERT INTO  facultadBE VALUES(
  id_Facu INT NOT NULL,
  nombre_Facu varchar(100) NOT NULL,
  PRIMARY KEY (id_Facu)
) ;
--Creacion escuelaBE--
--descripcion: Todas las escuelas de la UNJFSC
--
INSERT INTO  escuelaBE VALUES(
  id_Escuela INT NOT NULL,
  nombre_Escuela varchar(100) NOT NULL,
  facultadId_Escuela INT NOT NULL,
  PRIMARY KEY (id_Escuela),
  CONSTRAINT fk_EscuelaBE_FacultadBE1 FOREIGN KEY (facultadId_Escuela) REFERENCES facultadBE (id_Facu)
) ;
--Creacion personalBE--
--descripcion: nombre del pesonal que estará a cargo de la cuenta de usuario
--
INSERT INTO  personalBE VALUES(
  id_Personal INT NOT NULL,
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
INSERT INTO  usuarioBE VALUES(
  id_Usu INT NOT NULL,
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
INSERT INTO  asistenteBE VALUES(
  id_Asis INT NOT NULL,
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
INSERT INTO  proyectoBE VALUES(
  id_Proyecto INT NOT NULL,
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
INSERT INTO  comunidadAutoBE VALUES(
  id_CA INT NOT NULL,
  nombre_CA INT NOT NULL,
  usuReg INT NOT NULL,
  fecReg date NOT NULL,
  PRIMARY KEY (id_CA)
) ;
--Creacion comunidadProyBE--
--descripcion: tabla intermedia entre Proyectos y Comunidades Autonomas
--
INSERT INTO  comunidadProyBE VALUES(
  id_CP INT NOT NULL,
  proyecto_CP INT NOT NULL,
  comunidad_CP INT NOT NULL,
  PRIMARY KEY (id_CP),
  CONSTRAINT fk_ComunidadProyBE_ComunidadAutoBE1 FOREIGN KEY (comunidad_CP) REFERENCES comunidadautoBE (id_ca),
  CONSTRAINT fk_ComunidadProyBE_ProyectoBE1 FOREIGN KEY (proyecto_CP) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion convocatoriaBE--
--descripcion: Convocatorias a concursos 
--
INSERT INTO  convocatoriaBE VALUES(
  id_Conv INT NOT NULL,
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
INSERT INTO  entidadColaBE VALUES(
  id_EntidadCola INT NOT NULL,
  nombre varchar(45) NOT NULL,
  descripcion varchar(45) NOT NULL,
  usuReg INT NOT NULL,
  fecReg date NOT NULL,
  PRIMARY KEY (id_EntidadCola)
) ;
--Creacion entidadCProyBE--
--descripcion: tabla intermedia entre Proyectos y Entidades Colaboradoras 
--
INSERT INTO  entidadCProyBE VALUES(
  id_ECP INT NOT NULL,
  proyecto_ECP INT NOT NULL,
  entidadC_ECP INT NOT NULL,
  PRIMARY KEY (id_ECP),
  CONSTRAINT fk_EntidadCProyBE_EntidadColaBE1 FOREIGN KEY (entidadC_ECP) REFERENCES entidadcolaBE (id_entidadcola),
  CONSTRAINT fk_EntidadCProyBE_ProyectoBE1 FOREIGN KEY (proyecto_ECP) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion tesisBE--
--descripcion: tesis de todas las facultades y escuelas 
--
INSERT INTO  tesisBE VALUES(
  id_Tesis INT NOT NULL,
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
INSERT INTO  especialidadBE VALUES(
  id_Espe INT NOT NULL,
  descripcion_Espe varchar(45) DEFAULT NULL,
  estado_Espe INT DEFAULT NULL,
  PRIMARY KEY (id_Espe)
) ;
--Creacion tipoEventoBE--
--descripcion: tipos de eventos  
-- ponencias, ferias
INSERT INTO  tipoEventoBE VALUES(
  id_TipoEv INT NOT NULL,
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
INSERT INTO  eventoBE VALUES(
  id_Evento INT NOT NULL,
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
INSERT INTO  eventoAsistenteBE VALUES(
  id_EventoAsis INT NOT NULL,
  evento_EventoAsis INT DEFAULT NULL,
  asistente_EventoAsis INT DEFAULT NULL,
  PRIMARY KEY (id_EventoAsis),
  CONSTRAINT fk_EventoAsitente_AsistenteBE1 FOREIGN KEY (asistente_EventoAsis) REFERENCES asistenteBE (id_asis),
  CONSTRAINT fk_EventoAsitente_EventoBE1 FOREIGN KEY (evento_EventoAsis) REFERENCES eventoBE (id_evento)
) ;
--Creacion universidadBE--
--descripcion: universidad de procedencia de los ponentes 
--
INSERT INTO  universidadBE VALUES(
  id_Uni INT NOT NULL,
  nombre_Uni varchar(80) NOT NULL,
  PRIMARY KEY (id_Uni)
) ;
--Creacion ponenteBE--
--descripcion: ponentes de los eventos
--
INSERT INTO  ponenteBE VALUES(
  id_Ponente INT NOT NULL,
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
INSERT INTO  eventoDetalleBE VALUES(
  id_EventoDet INT NOT NULL,
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
INSERT INTO  fechaEjeBE VALUES(
  id_FE INT NOT NULL,
  actividad_FE varchar(150) NOT NULL,
  fecha date NOT NULL,
  PRIMARY KEY (id_FE)
) ;
--Creacion fechaProBE--
--descripcion: tabla intermedia entre Proyecto y sus fechas de ejecuciones
--
INSERT INTO  fechaProyBE VALUES(
  id_FP INT NOT NULL,
  proyecto_FP INT NOT NULL,
  fechaEje_FP INT NOT NULL,
  PRIMARY KEY (id_FP),
  CONSTRAINT fk_FechaProyBE_FechaEjeBE1 FOREIGN KEY (fechaEje_FP) REFERENCES fechaejeBE (id_fe),
  CONSTRAINT fk_FechaProyBE_ProyectoBE1 FOREIGN KEY (proyecto_FP) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion nosotrosBE--
--descripcion: Aqui se registrara la descripcion del Vicerrectorado
--
INSERT INTO  nosotrosBE VALUES(
  id_Nos INT NOT NULL,
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
INSERT INTO  noticiaBE VALUES(
  id_Noticia INT NOT NULL,
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
INSERT INTO  objetivoBE VALUES(
  id_Objetivo INT NOT NULL,
  descripcion varchar(200) NOT NULL,
  PRIMARY KEY (id_Objetivo)
) ;
--Creacion objetivoPryBE--
--descripcion: tabla intermedia entre un Proeycto y sus objetivos
--
INSERT INTO  objetivoPryBE VALUES(
  id_ObjetivoPry INT NOT NULL,
  proyecto_ObjetivoPry INT NOT NULL,
  objetivo_ObjetivoPry INT NOT NULL,
  PRIMARY KEY (id_ObjetivoPry),
  CONSTRAINT fk_ObjetivoPryBE_ObjetivoBE1 FOREIGN KEY (objetivo_ObjetivoPry) REFERENCES objetivoBE (id_objetivo),
  CONSTRAINT fk_ObjetivoPryBE_ProyectoBE1 FOREIGN KEY (proyecto_ObjetivoPry) REFERENCES proyectoBE (id_proyecto)
) ;
--Creacion pagoBE--
--descripcion: pagos para asistir a los eventos
--
INSERT INTO  pagoBE VALUES(
  id_Pago INT NOT NULL,
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
INSERT INTO  profesionBE VALUES(
  id_Prof INT NOT NULL,
  nombre_Prof varchar(80) NOT NULL,
  PRIMARY KEY (id_Prof)
) ;
--Creacion resolucionBE--
--descripcion: Aqui se registraran las Resoluciones del Vicerrectorado
--
INSERT INTO  resolucionBE VALUES(
  id_Resolucion INT NOT NULL,
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
INSERT INTO  resultadoBE VALUES(
  id_Resultado INT NOT NULL,
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
INSERT INTO  suscriptorBE VALUES(
  id_Susc INT NOT NULL,
  nombres_Susc varchar(45) NOT NULL,
  apellidos_Susc varchar(45) NOT NULL,
  correo_Susc varchar(45) NOT NULL,
  estado_Susc INT NOT NULL,
  entidad_Susc varchar(70) DEFAULT NULL,
  profesion_Susc INT DEFAULT NULL,
  PRIMARY KEY (id_Susc),
  CONSTRAINT fk_SuscriptorBE_ProfesionBE1 FOREIGN KEY (profesion_Susc) REFERENCES profesionBE (id_prof)
) ;





