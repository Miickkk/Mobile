package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class Cursos {
    //atributos
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunos;

    //construtor
    public Cursos(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunos = new ArrayList<>();
    }

    //adicionarAlunos
    public void adicionarAluno(Aluno aluno) {
        alunos.add(aluno);
    }

    //exibir informações do curso
    public void exibirInformacoesCurso() {
        System.out.println("Nome do Curso: " +nomeCurso);
        System.out.println("===============");
        System.out.println("Nome do Professor: " +professor.getNome());
        System.out.println("===============");
        System.out.println("Lista de Alunos");
        int i = 1;
        for (Aluno aluno : alunos) {
            System.out.println(i+ " "+aluno.getNome());
            i++;
        }
    }

}
