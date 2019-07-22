module Api
    module V1
        class AgendasController < ApplicationController
            
            def index

                agenda = Agenda.order('created_at DESC')
                render json:{status: 'Sucesso', message: 'Agendamentos', data:agenda}, status: :ok

            end

            def show 
                agenda = Agenda.find(params[:medico])
                render json:{status: 'Agenda do médico', message: 'Carregamento feito com sucesso', data:agenda}, status: :ok
            end

            def create
                
                agenda = Agenda.new(agenda_params)

                agenda.consulta = agenda.consulta.to_datetime
                agenda.fim_consulta = agenda.consulta.to_datetime + 30.minutes
                agenda.paciente = agenda.paciente.upcase
                agenda.medico = agenda.medico.upcase
                agenda.especialidade = agenda.especialidade.upcase

                if (Agenda.where(medico:agenda.medico,:consulta => agenda.consulta..agenda.fim_consulta - 1.minutes) == [])
                    if agenda.save
                        render json:{status: 'Agendamento realizado com Sucesso', message: 'Agendamento salvo', data:agenda}, status: :ok
                    else
                        render json:{status: 'Erro no agendamento', message: 'Agendamento não salvo', data:agenda.errors}, status: :unprocessable_entity
                
                    end
                else
                    render json:{status: 'Erro no agendamento', message: 'Agendamento não salvo', data:agenda.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                agenda = Agenda.find(params[:id])
                agenda.destroy
                render json:{status: 'Registro apagado', message: 'Registro apagado com sucesso', data:agenda}, status: :ok
            end

            def update
                agenda = Agenda.find(params[:id])
                if agenda.update_attributes(article_params)
                    render json:{status: 'Registro modificado', message: 'Registro modificado com sucesso', data:agenda}, status: :ok
                else
                    render json:{status: 'Erro na modificação', message: 'Agendamento não modificado', data:agenda.errors}, status: :unprocessable_entity
                end
            end
            private

            def agenda_params
                params.permit(:paciente,:medico,:especialidade,:consulta,:fim_consulta)
            end
            
        end        
    end    
end