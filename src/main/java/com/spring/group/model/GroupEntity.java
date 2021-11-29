package com.spring.group.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.spring.common.model.BaseTimeEntity;
import com.spring.security.model.UserEntity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Entity
@Table(name = "tb_group")
public class GroupEntity extends BaseTimeEntity{
	
	@Id
	@GeneratedValue
	private Long id;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(referencedColumnName = "email", foreignKey = @ForeignKey(name = "fk_group_user"))
	private UserEntity registrant;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(referencedColumnName = "email", foreignKey = @ForeignKey(name = "fk_group_member"))
	private UserEntity member;
	
	
	@Builder
	public GroupEntity(UserEntity member) {
		this.member = member;
	}
}
