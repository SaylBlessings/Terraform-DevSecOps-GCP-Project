from google.cloud import iam_v1
from google.cloud import iam_v1
from google.auth.transport.requests import Request
from google.auth import exceptions as auth_exceptions

def list_roles(project_id):
    client = iam_v1.IAMClient()
    resource_name = f"projects/{project_id}"
    
    try:
        roles = client.list_roles(name=resource_name)
        return roles
    except Exception as e:
        print(f"Error listing roles: {e}")
        return None

def check_permissions(project_id, member):
    client = iam_v1.IAMClient()
    resource_name = f"projects/{project_id}"

    try:
        permissions = client.query_grantable_roles(name=resource_name, full_resource_name=member)
        return permissions
    except Exception as e:
        print(f"Error checking permissions: {e}")
        return None

def list_roles(project_id):
    client = iam_v1.IAMClient()
    resource_name = f"projects/{project_id}"
    
    try:
        roles = client.list_roles(name=resource_name)
        return roles
    except Exception as e:
        print(f"Error listing roles: {e}")
        return None

def check_permissions(project_id, member):
    client = iam_v1.IAMClient()
    resource_name = f"projects/{project_id}"

    try:
        permissions = client.query_grantable_roles(name=resource_name, full_resource_name=member)
        return permissions
    except Exception as e:
        print(f"Error checking permissions: {e}")
        return None

def check_mfa(member_email):
    try:
        credentials, _ = iam_v1.IAMClient().get_iam_policy(request={"resource": member_email})
        return credentials.mfa_enabled
    except auth_exceptions.TransportError as e:
        print(f"Error checking MFA status: {e}")
        return None

def main():
    project_id = 'security-automation-414205'
    
    member = 'user:tessydinma81@gmail.com'

    print(f"Roles in project {project_id}:")
    roles = list_roles(project_id)
    if roles:
        for role in roles:
            print(role.name)

    print(f"\nPermissions for {member} in project {project_id}:")
    permissions = check_permissions(project_id, member)
    if permissions:
        for permission in permissions:
            print(permission)

    print(f"\nMFA status for {member}:")
    mfa_status = check_mfa(member)
    if mfa_status is not None:
        print(f"MFA Enabled: {mfa_status}")

if __name__ == "__main__":
    main()
